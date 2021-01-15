//
//  TTItemButton.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTItemButton.h"

@implementation TTItemButton

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setImageEdgeInsets:UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-10, 0, 0, -self.titleLabel.intrinsicContentSize.width)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.intrinsicContentSize.height, -self.imageView.intrinsicContentSize.width, 0, 0)];
        [self setTitleColor:[UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:0.97 green:0.35 blue:0.35 alpha:1] forState:UIControlStateSelected];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
