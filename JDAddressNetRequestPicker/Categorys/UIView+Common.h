//
//  UIView+Common.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

-(void)showSuccess:(NSString *)info;
-(void)showError:(NSString *)info;

- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;

@end
