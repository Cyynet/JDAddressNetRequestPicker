//
//  ViewController.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import "ViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "TXLAddress.h"
#import "TXLTableCell.h"
#import "TXLAddressPickView.h"

#import "TMAddressViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property(nonatomic, strong) TPKeyboardAvoidingTableView *mytableView;
@property(nonatomic, strong) TXLAddress *address;
@property(nonatomic, assign) BOOL isEditing;
@property(nonatomic, strong) TXLAddressPickView *addressPickView;
@property(nonatomic, strong) UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新建收货地址";
    //self.address = [[TXLAddress alloc] init];
    [self initTable];
    //底部确定按钮
    [self setBottomView];
    //初始化地址选择模块
    //[self handlebackView];
}

- (void)initTable{
    _mytableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[TXLTableCell class] forCellReuseIdentifier:kCellIdentifier_TXLTableCell];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:tableView];
        tableView;
    });
}

- (void)handlebackView {
    self.backView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.39;
    self.backView.hidden = YES;
    [self.view addSubview:self.backView];
    UITapGestureRecognizer *blurviewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blurViewTaped:)];
    [self.backView addGestureRecognizer:blurviewTap];
    __weak typeof(self) weakSelf = self;
    self.addressPickView = [[TXLAddressPickView alloc] init:self.address];
    self.addressPickView.confirmBlock = ^(TXLAddress *address){
        address.userName = weakSelf.address.userName;
        address.phone = weakSelf.address.phone;
        address.address = weakSelf.address.address;
        weakSelf.address = address;
        [weakSelf hideSelectView];
        [weakSelf.mytableView reloadData];
    };
    [self.view addSubview:self.addressPickView];
}

- (void)jumpToSelectView{
    [UIView animateWithDuration:0.6 animations:^{
        self.backView.hidden = NO;
        [self.addressPickView setY:(kScreen_Height - 746/2)];
    }completion:^(BOOL finish){
        
    }];
}

- (void)hideSelectView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.hidden = YES;
        [self.addressPickView setY:kScreen_Height];
    }completion:^(BOOL finish){
        
    }];
}

- (void)blurViewTaped:(id)sender{
    [self hideSelectView];
}

- (void)setBottomView{
    UIButton *bottom  = [[UIButton alloc] initWithFrame:CGRectMake(10, kScreen_Height - 50, kScreen_Width -20, 40)];
    bottom.backgroundColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:60/255.0 alpha:1];
    bottom.layer.masksToBounds =YES;
    bottom.layer.cornerRadius = 4;
    [bottom setTitle:@"保存" forState:UIControlStateNormal];
    bottom.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottom setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottom addTarget:self action:@selector(bottomViewClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottom];
}

- (void)bottomViewClicked{
    [self.view showSuccess:@"地址创建成功"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        TXLTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TXLTableCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.address.provinceId){
            cell.title = [NSString stringWithFormat:@"%@%@%@",self.address.provinceName,self.address.cityName,self.address.districtName];
        }else{
            cell.title =  self.address.cityStr.length > 0 ? self.address.cityStr : @"省份城市";
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        UILabel *label = [UILabel new];
        label.text = @"重构版本";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(10, 0, 300, 45);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:label];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self jumpToSelectView];
    }else{
        TMAddressViewController *vc = [TMAddressViewController new];
        vc.title = @"重构版本";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
