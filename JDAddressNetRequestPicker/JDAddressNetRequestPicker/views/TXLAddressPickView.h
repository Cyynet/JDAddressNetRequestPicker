//
//  TXLAddressPickView.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLAddress.h"

@interface TXLAddressPickView : UIView

@property (nonatomic, copy) void (^confirmBlock)(TXLAddress *address);
@property (nonatomic, strong) TXLAddress *address;
- (instancetype)init:(TXLAddress *)address;
- (void)refreshWithAddress:(TXLAddress *)address;

@end
