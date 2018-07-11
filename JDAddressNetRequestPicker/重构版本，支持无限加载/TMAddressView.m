//
//  TMAddressView.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "TMAddressView.h"

#import "TMAddressTopContentView.h"
#import "TMAddressBomContentView.h"

#define coverViewHeight 350
#define topViewHeight 50

@interface TMAddressView ()
<UIGestureRecognizerDelegate,
TMAddressTopContentViewDelegate,
TMAddressBomContentViewDelegate>
{
    NSInteger index;
}
@property (nonatomic, strong)UIView *coverView;
@property (nonatomic, strong)TMAddressTopContentView *topView;
@property (nonatomic, strong)TMAddressBomContentView *bomView;

@end

@implementation TMAddressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *coverButton = [UIButton new];
        coverButton.frame = frame;
        [coverButton addTarget:self action:@selector(hiddenFromSuperView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverButton];
        
        [self addSubview:self.coverView];
        [self.coverView addSubview:self.topView];
        [self.coverView addSubview:self.bomView];
    }
    return self;
}

#pragma mark - delegate

/* 点击了topView Title */
- (void)topContentViewDidSelectedAtIndex:(NSInteger)index{
    [self.bomView topViewContentDidSelectedIndex:index];
}

- (void)bomttomContentViewDidSelectedAtIndex:(NSInteger)index{
    [self.topView updateLineViewFrameAtIndex:index];
}

/* update title and add title */
- (void)bomttomContentViewDidUpdateTittleAtIndex:(NSInteger)index title:(NSString *)title hasNext:(BOOL)isNext{
    [self.topView updateWithText:title atIndex:index isNext:isNext];
}

- (void)bomttomContentViewDidSelectedAddress:(NSString *)address{
    NSLog(@"-->><>>><><><><%@",address);
    [self hiddenFromSuperView];
}

- (void)bomttomContentViewDidUpdateAllTitlesAtIndex:(NSInteger)index{
    [self.topView updateCutDownAllTitlesAtIndexPath:index];
}

#pragma mark - show

- (void)showInView:(UIView *)superView{
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
    __block CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(0, height, self.frame.size.width, self.frame.size.height);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }];
}

- (void)hiddenFromSuperView{
    __block CGFloat height = self.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - lazyLoad

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - coverViewHeight, self.frame.size.width, coverViewHeight)];
        _coverView.backgroundColor = [UIColor whiteColor];
    }
    return _coverView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[TMAddressTopContentView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, topViewHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.delegate = self;
    }
    return _topView;
}

-(UIView *)bomView{
    if (!_bomView) {
        _bomView = [[TMAddressBomContentView alloc]initWithFrame:CGRectMake(0, topViewHeight, self.frame.size.width, coverViewHeight - topViewHeight)];
        _bomView.backgroundColor = [UIColor whiteColor];
        _bomView.delegate = self;
    }
    return _bomView;
}

@end
