//
//  TMAddressTableView.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMAddressModel.h"

@interface TMAddressTableView : UITableView

- (void)startRequestServerDataByRequestId:(NSString *)requestId callBackBlock:(void(^)(NSArray *array))callBackBlock;

@end
