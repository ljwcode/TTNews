//
//  TTReportArticleView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTReportArticleView.h"
#import "TTloginView.h"

@interface TTReportArticleView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *imgArray;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *tableHeaderView;

@property(nonatomic,strong)NSArray *writeTitleArray;

@property(nonatomic,strong)NSArray *writeDescriptionArray;

@end

@implementation TTReportArticleView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self addSubview:self.tableView];
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        loginBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
        loginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, loginBtn.titleLabel.intrinsicContentSize.width, 0, -loginBtn.titleLabel.intrinsicContentSize.width);
        loginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -loginBtn.imageView.intrinsicContentSize.width, 0, loginBtn.imageView.intrinsicContentSize.width);
        [loginBtn addTarget:self action:@selector(TologinHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableHeaderView addSubview:loginBtn];
        
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(hSpace);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        for(int i = 0;i < self.titleArray.count;i++){
            UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [publishBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            publishBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
            publishBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [publishBtn setImage:[UIImage imageNamed:self.imgArray[i]] forState:UIControlStateNormal];
            publishBtn.imageEdgeInsets = UIEdgeInsetsMake(-publishBtn.titleLabel.intrinsicContentSize.height/2, 0, 0, 0);
            publishBtn.titleEdgeInsets = UIEdgeInsetsMake(publishBtn.imageView.intrinsicContentSize.height, -publishBtn.imageView.intrinsicContentSize.width, 0, 0);
            [self.tableHeaderView addSubview:publishBtn];
            
            [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(loginBtn.mas_bottom).offset(2 * vSpace);
                make.left.mas_equalTo(hSpace + i * (50 + (kScreenWidth - 2 * hSpace - 5 * 50)/4));
                make.width.height.mas_equalTo(50);
            }];
        }
        
    }
    return self;
}

#pragma mark ----- UITableViewDatasource && UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 2){
        return 1;
    }else{
        return 2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *resultCell = nil;
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [cell.contentView addSubview:self.tableHeaderView];
        }
        resultCell = cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = self.writeTitleArray[indexPath.row];
            UIButton *writeHotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [writeHotBtn setFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame) * 0.3, CGRectGetHeight(cell.frame) * 0.5)];
            [writeHotBtn setTitle:self.writeDescriptionArray[indexPath.row] forState:UIControlStateNormal];
            [writeHotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [writeHotBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
            writeHotBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            writeHotBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            writeHotBtn.imageEdgeInsets = UIEdgeInsetsMake(0, writeHotBtn.titleLabel.intrinsicContentSize.width, 0, -writeHotBtn.titleLabel.intrinsicContentSize.width);
            writeHotBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -writeHotBtn.imageView.intrinsicContentSize.width, 0, writeHotBtn.imageView.intrinsicContentSize.width);
            cell.accessoryView = writeHotBtn;
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor grayColor];
            lineView.alpha = 0.1;
            [cell addSubview:lineView];
            
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace);
                make.right.mas_equalTo(-hSpace);
                make.bottom.mas_equalTo(cell.mas_bottom).offset(0);
                make.height.mas_equalTo(1);
            }];
        }
        resultCell = cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            UIButton *closeBtn = [[UIButton alloc]init];
            [closeBtn setImage:[UIImage imageNamed:@"tta_close_move_details_press"] forState:UIControlStateNormal];
            [closeBtn addTarget:self action:@selector(closeHandle:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:closeBtn];
            
            [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.centerY.mas_equalTo(cell.contentView);
                make.width.height.mas_equalTo(20);
            }];
        }
        resultCell = cell;
    }
    return resultCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 || section == 2){
        return 0.01;
    }else{
        return 10;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return kScreenHeight * 0.2;
    }else if(indexPath.section == 2){
        return kScreenHeight * 0.1 - 10;
    }else{
        return kScreenHeight * 0.1;
    }
}

#pragma mark ---- 响应事件

-(void)TologinHandle:(UIButton *)sender{
    TTloginView *loginView = [[TTloginView alloc]init];
    [loginView show];
}

-(void)closeHandle:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(TT_deallocReportArticleView)]){
        [self.delegate TT_deallocReportArticleView];
    }
}

#pragma mark ---- lazy load

-(NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = [NSArray arrayWithObjects:@"发微头条",@"写文章",@"发问答",@"发视频",@"开直播", nil];
    }
    return _titleArray;
}

-(NSArray *)imgArray{
    if(!_imgArray){
        _imgArray = [NSArray arrayWithObjects:@"icon_photo&article_titlebar_v2",@"icon_publisher_aggr_image_text",@"tabbar_publish_question",@"icon_video_titlebar_v2",@"xiguaLive&article_titlebar_v2-1", nil];
    }
    return _imgArray;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(UIView *)tableHeaderView{
    if(!_tableHeaderView){
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.2)];
    }
    return _tableHeaderView;
}

-(NSArray *)writeTitleArray{
    if(!_writeTitleArray){
        _writeTitleArray = [NSArray arrayWithObjects:@"创作热点",@"创作活动", nil];
    }
    return _writeTitleArray;
}

-(NSArray *)writeDescriptionArray{
    if(!_writeDescriptionArray){
        _writeDescriptionArray = [NSArray arrayWithObjects:@"平台热点，立即参与",@"参与活动，赢取奖励", nil];
    }
    return _writeDescriptionArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation UITableViewCell (TTTableViewCellLineShow)


@end
