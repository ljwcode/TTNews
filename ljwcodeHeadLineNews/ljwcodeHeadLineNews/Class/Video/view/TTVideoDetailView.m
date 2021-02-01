//
//  TTVideoDetailView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTVideoDetailView.h"
#import <Masonry/Masonry.h>
#import "UILabel+Frame.h"

@interface TTVideoDetailView()

@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation TTVideoDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.right.mas_equalTo(-hSpace);
            
        }];
    }
    return self;
}


#pragma mark ----- lazy load

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel TTContentFitWidth];
        [_titleLabel TTContentFitHeight];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
