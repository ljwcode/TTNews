//
//  TTCloseNotificationTipView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/17.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTCloseNotificationTipView.h"

@interface TTCloseNotificationTipView()

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,strong)NSArray *nameArray;

@end

@implementation TTCloseNotificationTipView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.isSelected = false;
        self.backgroundColor = [UIColor whiteColor];
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"popup_newclose"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(vSpace/2);
            make.left.mas_equalTo(hSpace);
            make.width.height.mas_equalTo(30);
        }];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        submitBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [submitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submitHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitBtn];
        
        [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-hSpace);
            make.top.mas_equalTo(vSpace/2);
            make.width.height.mas_equalTo(30);
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"你关闭推送通知的原因是?";
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.font = [UIFont systemFontOfSize:15.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(closeBtn.mas_bottom).offset(vSpace);
            make.height.mas_equalTo(vSpace * 1.5);
            make.width.mas_equalTo(self.width * 0.6);
        }];
        
        [self createUI];
    }
    return self;
}


- (void)createUI{
    CGFloat w = 0; CGFloat h = 10 + 6.5 * vSpace; for (int i = 0; i< self.nameArray.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //获取文字的长度
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        CGFloat length = [self.nameArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        btn.frame = CGRectMake(10 + w, h, length + 15 , 30);
        
        //当大于屏幕的宽度自动换
        if (10 + w + length + 15 > kScreenWidth)
        {
            w = 0;
            h = h + btn.frame.size.height + 10;
            btn.frame = CGRectMake(10 + w, h, length + 15 , 30);
        }
        w = btn.frame.size.width + btn.frame.origin.x;
        
        [btn setTitle:self.nameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(TipReasonHandle:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+10;
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.clipsToBounds = YES;
        
        [self addSubview:btn];
    }
}

#pragma mark ---- lazy load
-(NSArray *)nameArray{
    if(!_nameArray){
        _nameArray = [NSArray arrayWithObjects:@"推送太频繁",@"内容质量差",@"时间不合适",@"没有感兴趣的内容",@"其他", nil];
    }
    return _nameArray;
}
    
#pragma mark ---- 响应事件
-(void)closeHandle:(id)sender{
    [self hide];
}

-(void)submitHandle:(id)sender{
    if(!self.isSelected){
        [MBProgressHUD showSuccess:@"请选择关闭的原因"];
    }else{
        
    }
}

-(void)TipReasonHandle:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        self.isSelected = true;
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        
    }
}

#pragma mark ---- hide

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
