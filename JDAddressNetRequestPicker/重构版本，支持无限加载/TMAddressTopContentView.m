//
//  TMAddressTopContentView.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "TMAddressTopContentView.h"
#import "UIView+Frame.h"

#define leftMargin 20
#define margin 20

@interface TMAddressTopContentView ()
<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSMutableArray *tags;
@property (nonatomic, strong)UIView *underLine;

@end

@implementation TMAddressTopContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = YES;
        self.scrollView.scrollEnabled = YES;
        [self addSubview:self.scrollView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        [self addSubview:lineView];
        
        self.underLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-3, 0, 3)];
        self.underLine.backgroundColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:60/255.0 alpha:1];;
        [self.scrollView addSubview:self.underLine];
        
        /* 初始化 */
        [self updateHeadLine];
    }
    return self;
}

- (void)updateHeadLine{
    
    UIButton *selectButton = [self fetchButtonOriginal:@"请选择"];
    selectButton.tag = 0;
    
    selectButton.frame = CGRectMake(leftMargin, 0, CGRectGetWidth(selectButton.frame), self.frame.size.height);
    [self.scrollView addSubview:selectButton];
    
    self.underLine.tag = 1000;
    [self.underLine setX:leftMargin];
    [self.underLine setWidth:CGRectGetWidth(selectButton.frame)];
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.frame), self.frame.size.height);
}

- (void)updateWithText:(NSString *)title atIndex:(NSUInteger)index isNext:(BOOL)ret{
    if (index < self.tags.count) {
        
        UIButton *button = [self.tags objectAtIndex:index];
        [button setTitle:title forState:UIControlStateNormal];
        [button sizeToFit];
        if (index == 0) {
            button.frame = CGRectMake(leftMargin, 0, CGRectGetWidth(button.frame), self.frame.size.height);
        }else{
            UIButton *indexButton = [self.tags objectAtIndex:index - 1];
            button.frame = CGRectMake(CGRectGetMaxX(indexButton.frame) + margin, 0, CGRectGetWidth(button.frame), self.frame.size.height);
        }
        
        if (ret) {
            UIButton *selectButton = [self fetchButtonOriginal:@"请选择"];
            selectButton.tag = index + 1;
            
            selectButton.frame = CGRectMake(CGRectGetMaxX(button.frame) + margin, 0, CGRectGetWidth(selectButton.frame), self.frame.size.height);
            [self.scrollView addSubview:selectButton];
        }
        
        UIButton *lastButton = [self.tags lastObject];
        self.underLine.tag = 1000 + lastButton.tag;
        [self.underLine setX:CGRectGetMinX(lastButton.frame)];
        [self.underLine setWidth:CGRectGetWidth(lastButton.frame)];
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastButton.frame) + 20, self.frame.size.height);
    }
}

/**
 更新lineView到当前的index下
 
 @param index index
 */
- (void)updateLineViewFrameAtIndex:(NSInteger)index{
    if (index < self.tags.count) {
        UIButton *lastButton = [self.tags objectAtIndex:index];
        [UIView animateWithDuration:0.25 animations:^{
            [self.underLine setX:CGRectGetMinX(lastButton.frame)];
            [self.underLine setWidth:CGRectGetWidth(lastButton.frame)];
        } completion:^(BOOL finished) {
            self.underLine.tag = 1000 + lastButton.tag;
        }];
    }
}

- (void)tapActionClickEvent:(UIButton *)sender{
    UIButton *currentButton = (UIButton *)sender;
    if (self.underLine.tag - 1000 == currentButton.tag) {
        return ;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(topContentViewDidSelectedAtIndex:)]) {
        [self.delegate topContentViewDidSelectedAtIndex:currentButton.tag];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.underLine setX:CGRectGetMinX(currentButton.frame)];
        [self.underLine setWidth:CGRectGetWidth(currentButton.frame)];
    } completion:^(BOOL finished) {
        self.underLine.tag = 1000 + currentButton.tag;
    }];
}

/**
 截取前面的部分的信息
 
 @param index index
 */
- (void)updateCutDownAllTitlesAtIndexPath:(NSInteger)index{
    NSArray *smalltags = [self.tags.copy subarrayWithRange:NSMakeRange(0, index + 1)];
    [self.tags removeAllObjects];
    [self.tags addObjectsFromArray:smalltags];
    for (UIButton *button in self.scrollView.subviews) {
        if (button.tag > index && [button isKindOfClass:[UIButton class]]) {
            [button removeFromSuperview];
        }
    }
}

#pragma mark - lazyLoad

- (UIButton *)fetchButtonOriginal:(NSString *)text{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button sizeToFit];
    button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [button addTarget:self action:@selector(tapActionClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.tags addObject:button];
    return button;
}

- (NSMutableArray *)tags{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

@end
