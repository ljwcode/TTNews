//
//  MineViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "MineViewController.h"
#import "mineHeaderTableView.h"
#import <UIView+Frame.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import "screeningHallTableViewCell.h"
#import "commonSettingTableViewCell.h"
#import "moreSettingTableViewCell.h"
#import "loginView.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    CGFloat sectionHeight;
}
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UIView *footerView;

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sectionHeight = kScreenHeight/4;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    // Do any additional setup after loading the view from its nib.
}
-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        mineHeaderTableView *headerView = [[mineHeaderTableView alloc]init];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.3);
        self.headerView = headerView;
        headerView.loginBlock = ^{
            loginView *loginV = [[loginView alloc]init];
            [loginV show];
        };
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectZero];
        self.footerView = footerView;
        tableView.tableFooterView = footerView;
        
        tableView.tableHeaderView = headerView;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch(indexPath.section){
        case 0:
            return self.view.height/4;
            break;
        case 1:
        case 2:
            return kScreenHeight * 0.3;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultCell = nil;
    switch (indexPath.section) {
        case 0:
        {
            screeningHallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([screeningHallTableViewCell class])];
            if(!cell){
                cell = [[screeningHallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([screeningHallTableViewCell class])];
            }
            resultCell = cell;
        }
            break;
        case 1:
        {
            commonSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([commonSettingTableViewCell class])];
            if(!cell){
                cell = [[commonSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([commonSettingTableViewCell class])];
            }
            resultCell = cell;
        }
            break;
        case 2:
        {
            moreSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([moreSettingTableViewCell class])];
            if(!cell){
                cell = [[moreSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([moreSettingTableViewCell class])];
            }
            resultCell = cell;
        }
            break;
            
        default:
            break;
    }
    
    return resultCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat hey = CGRectGetMaxY(self.headerView.frame);
    if (y <= -30 || y >= hey-40) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
