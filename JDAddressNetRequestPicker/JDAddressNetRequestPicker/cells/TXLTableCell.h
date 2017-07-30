//
//  TXLTableCell.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//  选择显示cell

#import <UIKit/UIKit.h>
#define kCellIdentifier_TXLTableCell @"TXLTableCell"

@interface TXLTableCell : UITableViewCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, assign) BOOL needStatus;

@end
