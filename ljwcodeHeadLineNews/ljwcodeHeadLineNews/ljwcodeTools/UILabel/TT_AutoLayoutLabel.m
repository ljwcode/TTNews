//
//  TT_AutoLayoutLabel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/8.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_AutoLayoutLabel.h"

@interface TT_AutoLayoutLabel()


@end

@implementation TT_AutoLayoutLabel

/*
 UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
 CGSize Size = CGSizeMake(CGRectGetWidth(view.frame), MAXFLOAT);
 NSString *context = @"All Rights Reserved By Toutiao.com";
 NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.f]};
 CGSize size = [context boundingRectWithSize:Size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
 tipLabel.textColor = [UIColor grayColor];
 tipLabel.text = context;
 tipLabel.font = [UIFont systemFontOfSize:13.f];
 tipLabel.textAlignment = NSTextAlignmentCenter;
 [tipLabel setFrame:CGRectMake(0, 0, size.width, size.height)];
 tipLabel.center = view.center;
 [view addSubview:tipLabel];
 */

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
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
