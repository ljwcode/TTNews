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

-(instancetype)initWithFrame:(CGRect)frame withContent:(NSString *)text withTextColor:(UIColor *)color WithSuperView:(UIView *)superView{
    if(self = [super initWithFrame:frame]){
        self.frame = frame;
        self.text = text;
        self.textColor = color;
        self.textAlignment = NSTextAlignmentCenter;
        CGSize size = CGSizeMake(CGRectGetWidth(superView.frame), MAXFLOAT);
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:TT_DEFAULT_FONT_SIZE]};
        CGSize labelSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        self.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        [self setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
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
