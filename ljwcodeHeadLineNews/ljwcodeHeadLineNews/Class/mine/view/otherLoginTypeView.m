//
//  otherLoginTypeView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "otherLoginTypeView.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface otherLoginTypeView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UITableView *alertSheetView;

@property(nonatomic,strong)NSArray *infoArray;

@end

@implementation otherLoginTypeView

- (void)dealloc{
    
    self.alertSheetView = nil;
    self.infoArray = nil;
}

#pragma mark - 初始化

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight*0.3);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClose:)];
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addGestureRecognizer:tap];
        
    }
    return self;
}

/*
 点击空白处关闭
 */

-(void)tapClose:(UITapGestureRecognizer *)tap{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        CGPoint tapPoint = [tap locationInView:[UIApplication sharedApplication].delegate.window.rootViewController.view];
        CGRect floatRect = self.alertSheetView.bounds;
        
        if (self.alertSheetView && !CGRectContainsPoint(floatRect, tapPoint))
        {
            
            [self.alertSheetView.window removeGestureRecognizer:tap];
            [self removeFromSuperview];
        }
        
    }
}

#pragma mark - 初始化数据

- (NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = [[NSArray alloc]init];
        _infoArray = @[
            @{@"title" : @"密码登陆" , @"image" : @"login_other_pw" , @"type" : [NSNumber numberWithInteger:LoginTypeToPassWd]} ,
            
            @{@"title" : @"天翼登陆" , @"image" : @"login_other_ty" ,  @"type" : [NSNumber numberWithInteger:LoginTypeToTianyi]} ,
                        
            @{@"title" : @"QQ登陆" , @"image" : @"login_other_qq" ,  @"type" : [NSNumber numberWithInteger:LoginTypeToQQ]} ,
            
            @{@"title" : @"微信登陆" , @"image" : @"login_other_wx" , @"type" : [NSNumber numberWithInteger:LoginTypeToWeChat]}];
    }
    return _infoArray;
}

-(UITableView *)alertSheetView{
    if(!_alertSheetView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _alertSheetView = tableView;
    }
    return _alertSheetView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIImageView *titleImgView = [[UIImageView alloc]init];
        [cell.contentView addSubview:titleImgView];
        [titleImgView setTag:100003];
        [titleImgView sizeToFit];
        titleImgView.layer.borderColor = [UIColor redColor].CGColor;
        titleImgView.layer.borderWidth = 2.f;
        [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.contentView);
            make.centerY.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(cell.contentView);
        }];
        
        UILabel *detailLabel = [[UILabel alloc]init];
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.layer.borderColor = [UIColor redColor].CGColor;
        detailLabel.layer.borderWidth = 2.f;
        detailLabel.font = [UIFont systemFontOfSize:15.f];
        [cell.contentView addSubview:detailLabel];
        [detailLabel sizeToFit];
        [detailLabel setTag:100004];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleImgView.mas_right).offset(10);
            make.top.mas_equalTo(titleImgView);
            make.height.mas_equalTo(titleImgView);
            make.right.mas_lessThanOrEqualTo(cell.contentView.width*0.5);
        }];
    }
    UIImageView *titleImgView = (UIImageView *)[cell.contentView viewWithTag:100003];
    UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:100004];
    titleImgView.image = [UIImage imageNamed:self.infoArray[indexPath.row][@"image"]];
    detailLabel.text = self.infoArray[indexPath.row][@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 点击按钮跳转拉起第三方登陆

- (void)loginButtonHandle:(UIButton *)sender{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
