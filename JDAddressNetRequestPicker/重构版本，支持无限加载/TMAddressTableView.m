//
//  TMAddressTableView.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "TMAddressTableView.h"

@interface TMAddressTableView ()

@end

@implementation TMAddressTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)startRequestServerDataByRequestId:(NSString *)requestId callBackBlock:(void(^)(NSArray *array))callBackBlock{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *array = @[].mutableCopy;
        NSArray *arr1 = @[@"北京",@"北京北",@"北京北京",@"北京北",@"北北京",@"北京北京"];
        for (int i = 0; i < 10; i ++) {
            TMAddressModel *model = [[TMAddressModel alloc] init];
            model.name = arr1[arc4random()%(arr1.count)];
            model.overId = [requestId isEqualToString:@"3"] ? nil : [NSString stringWithFormat:@"%d", [requestId intValue] + 1];
            [array addObject:model];
        }
        callBackBlock(array.copy);
    });
}

@end




























