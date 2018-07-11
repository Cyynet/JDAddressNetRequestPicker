//
//  TMAddressBomContentView.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMAddressBomContentView;
@protocol TMAddressBomContentViewDelegate<NSObject>

- (void)bomttomContentViewDidSelectedAtIndex:(NSInteger)index;
- (void)bomttomContentViewDidUpdateTittleAtIndex:(NSInteger)index title:(NSString *)title hasNext:(BOOL)isNext;
- (void)bomttomContentViewDidSelectedAddress:(NSString *)address;
- (void)bomttomContentViewDidUpdateAllTitlesAtIndex:(NSInteger)index;

@end

@interface TMAddressBomContentView : UIView

@property (nonatomic, weak)id<TMAddressBomContentViewDelegate> delegate;

/* 点击top传递事件 */
- (void)topViewContentDidSelectedIndex:(NSInteger)index;

@end
