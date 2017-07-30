//
//  TXLAddress.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXLAddrObject.h"

@interface TXLAddress : NSObject

@property (nonatomic, strong) NSString *userName , *phone, *address, *cityName, *provinceName, *userId, *zipCode, *cityStr, *districtName, *fullAddress , *defaultFlag;
@property (nonatomic, strong) TXLAddrObject *province, *city, *district;
@property (nonatomic, strong) NSString *cityId, *provinceId, *distId, *addressId;
@property (nonatomic, assign) BOOL isSelected;

-(NSDictionary *)toParams;

@end
