//
//  MessageViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/13.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "MessageViewController.h"
#import <UIView+Frame.h>
#import <Masonry.h>
#import "TTNavigationController.h"
#import "TTloginView.h"
#import "showAllMsgChannelView.h"

@interface MessageViewController ()

@property(nonatomic,weak)UILabel *tipLabel;

@property(nonatomic,weak)UIButton *loginBtn;

@property(nonatomic,strong)showAllMsgChannelView *showView;

@end

@implementation MessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TTNavigationController *nav = (TTNavigationController *)self.navigationController;
    [nav startGestureRecnozier];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNaviItem];
    
    [self createMainUI];
    // Do any additional setup after loading the view.
}

-(void)createMainUI{
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tipLabel.mas_bottom).offset(2 * vSpace);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.tipLabel.width + 2 * hSpace);
        make.height.mas_equalTo(self.tipLabel.height * 2);
    }];
}


-(void)createNaviItem{
    UIImage *leftBackImg = [[UIImage imageNamed:@"lefterbackicon_titlebar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithImage:leftBackImg style:UIBarButtonItemStylePlain target:self action:@selector(leftBackHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"全部消息" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [titleBtn setImage:[UIImage imageNamed:@"personal_home_recommend_down_black"] forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleBtn.titleLabel.intrinsicContentSize.width, 0, -titleBtn.titleLabel.intrinsicContentSize.width);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -titleBtn.imageView.intrinsicContentSize.width, 0, titleBtn.imageView.intrinsicContentSize.width);
    
    self.navigationItem.titleView = titleBtn;
}

#pragma mark - 点击事件

-(void)leftBackHandle:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)titleHandle:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        [sender setImage:[UIImage imageNamed:@"personal_home_recommend_up_black"] forState:UIControlStateNormal];
        _showView = [[showAllMsgChannelView alloc]init];
        [self.view addSubview:_showView];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = self->_showView.frame;
            rect.origin.y += self->_showView.height;
            self->_showView.frame = rect;
        }];
    }else{
        [sender setImage:[UIImage imageNamed:@"personal_home_recommend_down_black"] forState:UIControlStateNormal];
        _showView = [[showAllMsgChannelView alloc]init];
        [_showView removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = self->_showView.frame;
            rect.origin.y += 0;
            self->_showView.frame = rect;
        }];
       
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect rect = self->_showView.frame;
//            rect.origin.y -= self->_showView.height;
//            self->_showView.frame = rect;
//        }];
    }
}

-(void)loginHandle:(UIButton *)sender{
    TTloginView *view = [[TTloginView alloc]init];
    [view show];
}

#pragma mark - lazy load

-(UILabel *)tipLabel{
    if(!_tipLabel){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"登陆后可查看";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13.f];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [self.view addSubview:label];
        _tipLabel = label;
    }
    return _tipLabel;
}

-(UIButton *)loginBtn{
    if(!_loginBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"立即登陆" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [btn setBackgroundColor:[UIColor orangeColor]];
        [btn addTarget:self action:@selector(loginHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _loginBtn = btn;
    }
    return _loginBtn;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
