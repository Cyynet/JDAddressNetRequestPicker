//
//  TMAddressTableViewCell.h
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMAddressTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, assign)BOOL isSelected;

+ (CGFloat)rowHeight;

@end
