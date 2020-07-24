//
//  MineViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "MineViewController.h"
#import "mineHeaderTableViewCell.h"
#import <UIView+Frame.h>
#import <MJRefresh/MJRefresh.h>
#import <Masonry/Masonry.h>
#import "screeningHallTableViewCell.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat sectionHeight;
}
@property(nonatomic,strong)UITableView *tableView;

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
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
        case 2:
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch(indexPath.section){
        case 0:
            return self.view.height/4;
            break;
        case 1:
        case 2:
        case 3:
            return sectionHeight;
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch(section){
        case 0:
            return 10;
            break;
        case 1:
        case 2:
        case 3:
            return 10;
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultCell = nil;
    switch (indexPath.section) {
        case 0:
        {
            mineHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([mineHeaderTableViewCell class])];
            if(!cell){
                cell = [[mineHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([mineHeaderTableViewCell class])];
            }
            resultCell = cell;
        }
            break;
        case 1:
        case 2:
        case 3:
        {
            screeningHallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([screeningHallTableViewCell class])];
            if(!cell){
                cell = [[screeningHallTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([screeningHallTableViewCell class])];
            }
            resultCell = cell;
        }
            break;
            
        default:
            break;
    }
    
    return resultCell;
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
