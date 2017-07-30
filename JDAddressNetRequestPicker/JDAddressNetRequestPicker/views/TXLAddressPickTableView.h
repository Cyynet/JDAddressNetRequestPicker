//
//  TXLAddressPickTableView.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLAddrObject.h"

@interface TXLAddressPickTableView : UIView

@property (nonatomic, copy) void (^addressPickBlock)(TXLAddrObject *object);
@property (nonatomic, strong) TXLAddrObject *picked;
@property (nonatomic, strong) NSString *type;
- (void)refresh:(NSString *)addressId currentId:(NSString *)currentId type:(NSString *)type;
- (void)scrollToCell;

@end
