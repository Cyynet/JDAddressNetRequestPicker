//
//  UILabel+Common.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2017/7/30.
//  Copyright © 2017年 cocomanber. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

- (void)updateWidth {
    [self setWidth:[self.text getWidthWithFont:self.font constrainedToSize:CGSizeMake(kScreen_Width, self.height)]];
}

@end

