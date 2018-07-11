//
//  TMAddressBomContentView.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "TMAddressBomContentView.h"
#import "TMAddressTableView.h"
#import "TMAddressTableViewCell.h"
#import "UIView+Loading.h"

@interface TMAddressBomContentView ()
<UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>
{
    TMAddressTableView *_currentTable;
}
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray <UITableView* >*tables;
@property (nonatomic, strong)NSMutableArray <NSArray *>*datas;

@end

@implementation TMAddressBomContentView

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.alwaysBounceHorizontal = NO;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.tables = @[].mutableCopy;
        self.datas = @[].mutableCopy;
        
        /* 初始化 */
        [self reloadInitialTable];
    }
    return self;
}

- (void)reloadInitialTable{
    TMAddressTableView *table = [self fetchTableOriginal:0];
    __weak __typeof(&*self)weakSelf = self;
    [self startLoading];
    [table startRequestServerDataByRequestId:@"0" callBackBlock:^(NSArray *array) {
        [weakSelf stopLoading];
        [weakSelf.datas addObject:array];
        [table reloadData];
    }];
}

/* 点击top传递事件 */
- (void)topViewContentDidSelectedIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:YES];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger lve = tableView.tag;
    if (lve < self.datas.count) {
        return [[self.datas objectAtIndex:lve] count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TMAddressTableViewCell rowHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TMAddressTableViewCell"];
    if (tableView.tag < self.datas.count) {
        NSArray *array = [self.datas objectAtIndex:tableView.tag];
        TMAddressModel *model = [array objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.name;
        cell.isSelected = model.isSelected;
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        [self stopLoading];
        NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
        if (self.delegate && [self.delegate respondsToSelector:@selector(bomttomContentViewDidSelectedAtIndex:)]) {
            [self.delegate bomttomContentViewDidSelectedAtIndex:index];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = [self.datas objectAtIndex:tableView.tag];
    for (int i = 0; i < array.count; i ++) {
        TMAddressModel *model = [array objectAtIndex:i];
        model.isSelected = NO;
    }
    TMAddressModel *model = [array objectAtIndex:indexPath.row];
    model.isSelected = YES;
    [tableView reloadData];

    /* 返回数据 */
    if (!model.overId) {
        /* 更新topContentView */
        if (self.delegate && [self.delegate respondsToSelector:@selector(bomttomContentViewDidUpdateTittleAtIndex:title:hasNext:)]) {
            [self.delegate bomttomContentViewDidUpdateTittleAtIndex:tableView.tag title:model.name hasNext:NO];
        }
        
        NSMutableArray *originalArray = @[].mutableCopy;
        for (NSArray *arr in self.datas) {
            for (TMAddressModel *originalModel in arr) {
                if (originalModel.isSelected) {
                    [originalArray addObject:originalModel.name];
                    break;
                }
            }
        }
        NSString *string = [originalArray componentsJoinedByString:@"-"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(bomttomContentViewDidSelectedAddress:)]) {
            [self.delegate bomttomContentViewDidSelectedAddress:string];
        }
    }
    /* 请求下一级 */
    else{
        
        /* 更新topContentView清空后面的数据 */
        if (tableView.tag < self.tables.count && self.datas.count >= 2 && tableView != self.tables.lastObject) {
            
            NSArray *smalldatas = [self.datas.copy subarrayWithRange:NSMakeRange(0, tableView.tag + 1)];
            [self.datas removeAllObjects];
            [self.datas addObjectsFromArray:smalldatas];
            
            NSArray *smalltables = [self.tables.copy subarrayWithRange:NSMakeRange(0, tableView.tag + 1)];
            [self.tables removeAllObjects];
            [self.tables addObjectsFromArray:smalltables];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(bomttomContentViewDidUpdateAllTitlesAtIndex:)]) {
                [self.delegate bomttomContentViewDidUpdateAllTitlesAtIndex:tableView.tag];
            }
        }
        
        /* 更新topContentView */
        if (self.delegate && [self.delegate respondsToSelector:@selector(bomttomContentViewDidUpdateTittleAtIndex:title:hasNext:)]) {
            [self.delegate bomttomContentViewDidUpdateTittleAtIndex:tableView.tag title:model.name hasNext:YES];
        }
        
        TMAddressTableView *table = [self fetchTableOriginal:tableView.tag + 1];
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * table.tag, 0) animated:YES];
        _currentTable = table;
        __weak __typeof(&*self)weakSelf = self;
        [self startLoading];
        
        [table startRequestServerDataByRequestId:model.overId callBackBlock:^(NSArray *array) {
            [weakSelf stopLoading];
            [weakSelf.datas addObject:array];
            [table reloadData];
        }];
    }
}

#pragma mark - lazyLoad

- (TMAddressTableView *)fetchTableOriginal:(NSInteger)tag{
    TMAddressTableView *table = [[TMAddressTableView alloc] initWithFrame:CGRectMake(self.frame.size.width *tag, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    table.tag = tag;
    table.delegate = self;
    table.dataSource = self;
    table.estimatedRowHeight = 0;
    table.estimatedSectionFooterHeight = 0;
    table.estimatedSectionHeaderHeight = 0;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [table registerClass:[TMAddressTableViewCell class] forCellReuseIdentifier:@"TMAddressTableViewCell"];
    [self.tables addObject:table];
    [self.scrollView addSubview:table];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (table.tag + 1), self.frame.size.height);
    return table;
}

@end
