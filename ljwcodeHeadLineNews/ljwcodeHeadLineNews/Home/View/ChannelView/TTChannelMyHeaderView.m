//
//  TTChannelMyHeaderView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTChannelMyHeaderView.h"

@interface TTChannelMyHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *clickChannelLabel;

@property (weak, nonatomic) IBOutlet UILabel *enterChannelLabel;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subTitle;

@property(nonatomic,assign)BOOL needEdit;

@end

@implementation TTChannelMyHeaderView

-(instancetype)newsChannelTitleView{
    NSString *className = NSStringFromClass([self class]);
    UINib *channelNib = [UINib nibWithNibName:className bundle:nil];
    return [channelNib instantiateWithOwner:nil options:nil].firstObject;
}

-(instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle needEdit:(BOOL)needEdit
{
    self = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:0].firstObject;
    self.clickChannelLabel.text = title;
    self.enterChannelLabel.text = subTitle;
    self.editButton.hidden = !needEdit;
    self.editButton.layer.cornerRadius = 10;
    self.enterChannelLabel.textColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];
    return self;
}

- (IBAction)clickEditButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        _enterChannelLabel.text = @"拖拽进行排序";
    }else{
        _enterChannelLabel.text = @"点击进入频道";
    }
    if(self.callBack){
        self.callBack(sender.selected);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
