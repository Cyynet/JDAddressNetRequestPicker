//
//  TMAddressTopContentView.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMAddressTopContentView;
@protocol TMAddressTopContentViewDelegate<NSObject>

- (void)topContentViewDidSelectedAtIndex:(NSInteger)index;

@end

@interface TMAddressTopContentView : UIView

@property (nonatomic, weak)id<TMAddressTopContentViewDelegate> delegate;

/**
 增加一个按钮

 @param title 按钮文字
 @param index 当前按钮所在index,后面的全要清空,已index为button的tag
 @param ret   是否需要追加一个“请选择”
 */
- (void)updateWithText:(NSString *)title atIndex:(NSUInteger)index isNext:(BOOL)ret;


/**
 更新lineView到当前的index下

 @param index index
 */
- (void)updateLineViewFrameAtIndex:(NSInteger)index;


/**
 截取前面的部分的信息

 @param index index
 */
- (void)updateCutDownAllTitlesAtIndexPath:(NSInteger)index;

@end
