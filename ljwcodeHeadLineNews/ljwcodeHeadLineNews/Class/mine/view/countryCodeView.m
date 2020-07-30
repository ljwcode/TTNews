//
//  countryCodeView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "countryCodeView.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@interface countryCodeView()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger A;
    NSInteger B;
    NSInteger C;
    NSInteger D;
    NSInteger E;
    NSInteger F;
    NSInteger G;
    NSInteger H;
    NSInteger I;
    NSInteger J;
    NSInteger K;
    NSInteger L;
    NSInteger M;
    NSInteger N;
    NSInteger O;
    NSInteger P;
    NSInteger Q;
    NSInteger R;
    NSInteger S;
    NSInteger T;
    NSInteger U;
    NSInteger V;
    NSInteger W;
    NSInteger X;
    NSInteger Y;
    NSInteger Z;
}

@property(nonatomic,strong)NSMutableArray *indexArray;

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,weak)UIView *headerView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

static CGFloat space = 10;
static NSString *cellID = @"cellID";
@implementation countryCodeView

/*
 索引列表
 */
-(NSMutableArray *)indexArray{
    if(!_indexArray){
        _indexArray = [NSMutableArray arrayWithObjects:@"#",nil];
        for (char ch='A'; ch<='Z'; ch++) {
            if (ch=='I' || ch=='O' || ch=='U' || ch=='V')
                continue;
            [_indexArray addObject:[NSString stringWithFormat:@"%c",ch]];
        }
    }
    return _indexArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:[UIImage imageNamed:@"close_sdk_register"] forState:UIControlStateNormal];
        [self.headerView addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.top.mas_equalTo(statuBarHeight);
            make.width.height.mas_equalTo(30);
        }];
        [closeButton addTarget:self action:@selector(closeHandle:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc]init];;
        titleLabel.text = @"选择国家和地区";
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:16.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headerView);
            make.centerY.mas_equalTo(closeButton);
            make.height.mas_equalTo(closeButton);
            make.width.mas_equalTo(kScreenWidth*0.4);
        }];
        [self calcNum];
    }
    return self;
}

-(void)calcNum{
    NSArray *array = [self.dataArray[0] objectForKey:@"All"];
    for(int i = 0;i < array.count;i++){
        if([[array[i] objectForKey:@"Pinyin"] hasPrefix:@"A"]){
            A++;
        }
        else if([[array[i] objectForKey:@"Pinyin"] hasPrefix:@"B"]){
            B++;
        }
        else if([[array[i] objectForKey:@"Pinyin"] hasPrefix:@"C"]){
            C++;
        }
    }
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"AreaCode" ofType:@"plist"];
        _dataArray = [[NSMutableArray alloc]initWithContentsOfFile:path];
    }
    return _dataArray;
}

-(UIView *)headerView{
    if(!_headerView){
        UIView *headerView = [[UIView alloc]init];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.1);
        self.tableView.tableHeaderView = headerView;
        _headerView = headerView;
    }
    return _headerView;
}

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch(section){
        case 0:
            return 4;
            break;
            
        case 1:
            return A;
            break;
        case 2:
            return B;
            break;
        case 3:
            return C;
            break;
            
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexArray.count + 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
        case 0:
            return @"常用";
            break;
        case 1:
            return @"A";
            break;
        case 2:
            return @"B";
            break;
        case 3:
            return @"C";
            break;
        case  4:
            return @"D";
            break;
        case 5:
            return @"E";
            break;
        case 6:
            return @"F";
            break;
        case 7:
            return @"G";
            break;
        case 8:
            return @"H";
            break;
        case 9:
            return @"I";
            break;
        case 10:
            return @"J";
            break;
        case 11:
            return @"K";
            break;
        case  12:
            return @"L";
            break;
        case 13:
            return @"M";
            break;
        case 14:
            return @"N";
            break;
        case 15:
            return @"O";
            break;
        case 16:
            return @"P";
            break;
        case 17:
            return @"Q";
            break;
        case 18:
            return @"R";
            break;
        case 19:
            return @"S";
            break;
        case  20:
            return @"T";
            break;
        case 21:
            return @"U";
            break;
        case 22:
            return @"V";
            break;
        case 23:
            return @"W";
            break;
        case 24:
            return @"X";
            break;
        case 25:
            return @"Y";
            break;
        case 26:
            return @"Z";
            break;
    }
    return @"";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:16.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
        [titleLabel setTag:100001];
        [titleLabel sizeToFit];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(space);
            make.centerY.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(cell);
        }];
        
        UILabel *detailLabel = [[UILabel alloc]init];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.font = [UIFont systemFontOfSize:16.f];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:detailLabel];
        [detailLabel setTag:100002];
        [detailLabel sizeToFit];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLabel.mas_right).offset(space);
            make.top.mas_equalTo(titleLabel);
            make.height.mas_equalTo(titleLabel);
            make.right.mas_lessThanOrEqualTo(cell.contentView.width/2);
        }];
    }
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:100001];
    
    UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:100002];
    
    switch(indexPath.section){
        case 0:
            titleLabel.text =  [[self.dataArray[0] objectForKey:@"Common"][indexPath.row]objectForKey:@"CNName"];
            detailLabel.text = [NSString stringWithFormat:@"+%@",[[self.dataArray[0] objectForKey:@"Common"][indexPath.row]objectForKey:@"Num"]];
            break;
        case 1:
            titleLabel.text =  [[self.dataArray[0] objectForKey:@"All"][indexPath.row]objectForKey:@"CNName"];
            detailLabel.text = [NSString stringWithFormat:@"+%@",[[self.dataArray[0] objectForKey:@"All"][indexPath.row]objectForKey:@"Num"]];
            break;
        case 2:
            titleLabel.text =  [[self.dataArray[0] objectForKey:@"All"][indexPath.row]objectForKey:@"CNName"];
            detailLabel.text = [NSString stringWithFormat:@"+%@",[[self.dataArray[0] objectForKey:@"All"][indexPath.row]objectForKey:@"Num"]];
            break;
            
        case 3:
            titleLabel.text =  [[self.dataArray[0] objectForKey:@"All"][indexPath.row]objectForKey:@"CNName"];
            detailLabel.text = [NSString stringWithFormat:@"+%@",[[self.dataArray[0] objectForKey:@"All"][indexPath.row]objectForKey:@"Num"]];
            break;
            
    }
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.didSelectCallback){
        self.didSelectCallback(indexPath.section == 0?[[self.dataArray[0]objectForKey:@"Common"][indexPath.row]objectForKey:@"Num"] : [[self.dataArray[0]objectForKey:@"All"][indexPath.row]objectForKey:@"Num"]);
        
    }
    [self removeFromSuperview];
}


#pragma mark - 响应事件

-(void)closeHandle:(UIButton *)sender{
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
