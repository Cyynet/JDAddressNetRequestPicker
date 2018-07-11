//
//  TMAddressTableViewCell.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "TMAddressTableViewCell.h"

@interface TMAddressTableViewCell ()

@property (nonatomic, strong)UIImageView *imageV;

@end

@implementation TMAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        [self.contentView addSubview:_titleLabel];
        
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_selected_ok"]];
        _imageV.hidden = YES;
        [self.contentView addSubview:_imageV];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    _imageV.hidden = !_isSelected;
    
    [self layoutIfNeeded];
}

+ (CGFloat)rowHeight{
    return 46.f;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.textColor = _isSelected?[UIColor orangeColor]:[UIColor lightGrayColor];
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(20, 0, CGRectGetMaxX(_titleLabel.frame), self.contentView.frame.size.height);
    _imageV.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), (self.contentView.frame.size.height - 16) / 2.0, 16, 16);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
