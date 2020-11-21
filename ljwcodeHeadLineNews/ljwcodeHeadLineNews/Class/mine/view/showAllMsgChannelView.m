//
//  showAllMsgChannelView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "showAllMsgChannelView.h"

@interface showAllMsgChannelView()

@property(nonatomic,strong)NSMutableArray *dataArr;

@end

static int columns = 4;
@implementation showAllMsgChannelView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setFrame:CGRectMake(0, -110, kScreenWidth, vSpace * 2 + (self.dataArr.count % columns) * 40 + ((self.dataArr.count % columns) - 1) * vSpace)];

        for(int i = 0;i < self.dataArr.count;i++){
            UIButton *channelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [channelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            channelBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            channelBtn.layer.borderColor = [UIColor systemPinkColor].CGColor;
            channelBtn.layer.borderWidth = 1.f;
            [channelBtn setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:channelBtn];
            
            [channelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.mas_equalTo(hSpace + (i%columns)*(hSpace + ((self.width - 5 * hSpace)/4)));
                make.top.mas_equalTo(vSpace + (i/columns) * (40 + vSpace));
                make.width.mas_equalTo((self.width - 5 * hSpace)/4);
                make.height.mas_equalTo(40);
            }];
            //a b c d
            [channelBtn setTitle:self.dataArr[i] forState:UIControlStateNormal];
        }
    }
    return self;
}

#pragma mark - lazy load
-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [[NSMutableArray alloc]initWithObjects:@"全部消息",@"系统通知",@"评论",@"新增粉丝",@"点赞",@"@我", nil];
    }
    return _dataArr;
}


-(void)hide{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
