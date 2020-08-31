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
#import <WXApi.h>

@interface otherLoginTypeView()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate>

@property(nonatomic,strong)UITableView *alertSheetView;

@property(nonatomic,strong)NSArray *infoArray;

@end
static NSString *cellID = @"OtherLoginCellID";
@implementation otherLoginTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight*0.3);
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        tableView.userInteractionEnabled = YES;
        NSLog(@"tableView:%@",NSStringFromCGRect(tableView.frame));
    }
    return self;
}

#pragma mark - 初始化数据

- (NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = [[NSArray alloc]init];
        _infoArray = @[
            @{@"title" : @"密码登陆" , @"image" : @"login_other_pw"},
            
            @{@"title" : @"天翼登陆" , @"image" : @"login_other_ty"},
                        
            @{@"title" : @"QQ登陆" , @"image" : @"login_other_qq"},
            
            @{@"title" : @"微信登陆" , @"image" : @"login_other_wx"}];
    }
    return _infoArray;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = cell.contentView.bounds;
        [btn setTag:10010];
        [cell.contentView addSubview:btn];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:10010];
    [btn setTitle:self.infoArray[indexPath.row][@"title"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [btn setImage:[UIImage imageNamed:self.infoArray[indexPath.row][@"image"]] forState:UIControlStateNormal];
//
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch(indexPath.row){
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            [self respToWechat];
            break;
            default:
            break;
            
    }
}

#pragma mark -- 跳转到WX

-(void)respToWechat{
    [WXApi registerApp:AppId universalLink:UniversalLink];
    if(self.delegate){
        [self.delegate RespToWX];
    }
    [self.getCurrentViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- WXApiDelegate
-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
