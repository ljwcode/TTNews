//
//  TTFeedDislikeView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/26.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTFeedDislikeView.h"
#import <Masonry/Masonry.h>
#import "homeNewsModel.h"
#import "UILabel+Frame.h"
@interface TTFeedDislikeView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *imgDataArray;

@property(nonatomic,strong)NSArray *filterWordsArray;

@end

@implementation TTFeedDislikeView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        UITableView *TTFeedDislikeOptionSelTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        TTFeedDislikeOptionSelTableView.delegate = self;
        TTFeedDislikeOptionSelTableView.dataSource = self;
        TTFeedDislikeOptionSelTableView.estimatedRowHeight = CGRectGetHeight(self.frame)/4;
        TTFeedDislikeOptionSelTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:TTFeedDislikeOptionSelTableView];
    }
    return self;
}

#pragma mark ----- UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        if(indexPath.row == 0){
            UIImageView *imgView = [[UIImageView alloc]init];
            imgView.image = [UIImage imageNamed:self.imgDataArray[indexPath.row]];
            [cell addSubview:imgView];
            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(2 * hSpace);
                make.centerY.mas_equalTo(cell);
                make.width.height.mas_equalTo(CGRectGetHeight(cell.frame)/2);
            }];
            UILabel *textLabel = [[UILabel alloc]init];
            textLabel.text = @"不感兴趣";
            textLabel.textColor = [UIColor blackColor];
            textLabel.font = [UIFont systemFontOfSize:13.f];
            textLabel.textAlignment = NSTextAlignmentLeft;
            [textLabel TTContentFitWidth];
            [textLabel TTContentFitHeight];
            [cell addSubview:textLabel];
            [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(imgView.mas_right).offset(hSpace/2);
                make.top.mas_equalTo(vSpace);
                make.width.mas_equalTo(CGRectGetWidth(cell.frame) * 0.2);
                make.height.mas_equalTo(CGRectGetHeight(cell.frame)/2);
            }];
            
            UILabel *detailLabel = [[UILabel alloc]init];
            detailLabel.text = @"减少这类内容";
            detailLabel.textColor = [UIColor lightGrayColor];
            detailLabel.font = [UIFont systemFontOfSize:11.f];
            detailLabel.textAlignment = NSTextAlignmentLeft;
            [detailLabel TTContentFitWidth];
            [detailLabel TTContentFitHeight];
            [cell addSubview:detailLabel];
            [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(textLabel);
                make.top.mas_equalTo(textLabel.mas_bottom).offset(0);
                make.height.mas_equalTo(textLabel);
                make.width.mas_equalTo(CGRectGetWidth(cell.frame) * 0.3);
            }];
            
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [cell addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(detailLabel.mas_bottom).offset(1);
                make.left.mas_equalTo(2 * hSpace);
                make.right.mas_equalTo(-2 * hSpace);
                make.height.mas_equalTo(1);
            }];
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight(self.frame)/4;
}

#pragma mark ------ lazy load

-(NSArray *)imgDataArray{
    if(!_imgDataArray){
        _imgDataArray = @[@"dislike",@"prompt",@"PopBlock",@"PopShield"];
    }
    return _imgDataArray;
}

-(NSArray *)filterWordsArray{
    if(!_filterWordsArray){
        
    }
    return _filterWordsArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
