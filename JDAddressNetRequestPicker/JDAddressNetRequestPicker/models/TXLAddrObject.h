//
//  TXLAddrObject.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXLAddrObject : NSObject

@property(nonatomic, strong) NSString *addrId;
@property(nonatomic, strong) NSString *addrName;
@property(nonatomic, assign) BOOL isSelected;

@end
