//
//  TTSlider.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTSlider.h"

@implementation TTSlider

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    UIImage *thumbImage = [UIImage imageNamed:@"TTRound"];
    [self setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
}

- (CGRect)trackRectForBounds:(CGRect)bounds{
    [super trackRectForBounds:bounds];
    return CGRectMake(bounds.origin.x, bounds.origin.y, CGRectGetWidth(bounds), 2);
}
//修改滑块位置
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    rect.origin.x = rect.origin.x - 6 ;
    rect.size.width = rect.size.width + 12;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
