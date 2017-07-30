//
//  TXLAddressPickCell.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import "TXLAddressPickCell.h"

@interface TXLAddressPickCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *icon;

@end

@implementation TXLAddressPickCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        if(!self.label){
            
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, kScreen_Width - 30, 45)];
            self.label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
            self.label.textAlignment = NSTextAlignmentLeft;
            self.label.textColor = [UIColor blackColor];
            [self.contentView addSubview:self.label];
            
            self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
            self.icon.image = [UIImage imageNamed:@"icon_dizhixuanze_duihao"];
            self.icon.contentMode = UIViewContentModeCenter;
            [self.contentView addSubview:self.icon];
            self.icon.hidden = YES;
            
            
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.label.text = self.object.addrName;
    [self.label updateWidth];
    if(self.isSelected){
        self.icon.hidden = NO;
        [self.icon setX:CGRectGetMaxX(self.label.frame)];
        self.label.textColor = [UIColor colorWithRed:255/255.0 green:106/255.0 blue:60/255.0 alpha:1];;
    }else{
        self.icon.hidden = YES;
        self.label.textColor = [UIColor blackColor];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
