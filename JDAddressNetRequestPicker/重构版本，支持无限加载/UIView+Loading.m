//
//  UIView+Loading.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/10.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "UIView+Loading.h"
#import <objc/runtime.h>

static NSString *kIndicatorView = @"kIndicatorView";

@interface UIView ()

@property (nonatomic, strong)UIActivityIndicatorView *indicatorView;

@end

@implementation UIView (Loading)

- (void)startLoading
{
    if (self.indicatorView == nil) {
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.indicatorView];
        self.indicatorView.center = self.center;
        [self.indicatorView setCenterY:self.centerY - 50];
    }
    [self.indicatorView startAnimating];
}

- (void)stopLoading
{
    if (self.indicatorView) {
        [self.indicatorView stopAnimating];
    }
}

- (void)setIndicatorView:(UIActivityIndicatorView *)indicatorView{
    objc_setAssociatedObject(self, &kIndicatorView, indicatorView, OBJC_ASSOCIATION_RETAIN);
}

- (UIActivityIndicatorView *)indicatorView{
    return objc_getAssociatedObject(self, &kIndicatorView);
}

@end
