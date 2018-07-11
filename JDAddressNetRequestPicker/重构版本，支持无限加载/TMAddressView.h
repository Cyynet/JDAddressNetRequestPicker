//
//  TMAddressView.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMAddressView;
@protocol TMAddressViewDelegate<NSObject>



@end

@interface TMAddressView : UIView

@property (nonatomic, weak)id<TMAddressViewDelegate> delegate;

- (void)showInView:(UIView *)superView;

- (void)hiddenFromSuperView;

@end
