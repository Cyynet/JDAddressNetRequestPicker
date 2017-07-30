//
//  TXLAddressPickCell.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLAddrObject.h"

#define kCellIdentifier_TXLAddressPickCell @"TXLAddressPickCell"

@interface TXLAddressPickCell : UITableViewCell

@property (nonatomic, strong) TXLAddrObject *object;
@property (nonatomic, assign) BOOL isSelected;

@end
