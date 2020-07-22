//
//  CircleButton.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor]set];
    CGContextFillRect(context, rect);
    
    CGRect ringRect = CGRectMake(0, 0, 15, 15);
    CGContextSetLineWidth(context, 1);
    CGContextAddEllipseInRect(context, ringRect);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextFillPath(context);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
