//
//  UILabel+Frame.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "UILabel+Frame.h"

@implementation UILabel (Frame)

- (void)TTContentFitHeight {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
    label.text = self.text;
    label.font = self.font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    self.numberOfLines = 0;
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width, height);
}

- (void)TTContentFitWidth {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, 0)];
    label.text = self.text;
    label.font = self.font;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

@end
