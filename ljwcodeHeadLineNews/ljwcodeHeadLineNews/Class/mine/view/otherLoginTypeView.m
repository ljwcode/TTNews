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

@interface otherLoginTypeView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *alertSheetView;

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
        _alertSheetView = tableView;
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
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:10010];
    [btn setTitle:self.infoArray[indexPath.row][@"title"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [btn setImage:[UIImage imageNamed:self.infoArray[indexPath.row][@"image"]] forState:UIControlStateNormal];
//
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
