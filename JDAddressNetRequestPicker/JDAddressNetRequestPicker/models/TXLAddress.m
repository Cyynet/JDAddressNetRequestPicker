//
//  TXLAddress.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import "TXLAddress.h"

@implementation TXLAddress

- (NSDictionary *)toParams {
    
    return @{
             @"phone":self.phone,
             @"userName":self.userName,
             
             @"provinceName":self.provinceName,
             @"cityName":self.cityName,
             @"address":self.address,
             @"addressId":self.addressId,
             @"districtName":self.districtName,
             @"defaultFlag":@"0"
             };
}

@end
