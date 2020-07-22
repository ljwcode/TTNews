//
//  CountryCodeSelectViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "CountryCodeSelectViewController.h"

@interface CountryCodeSelectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataListArray;

@end

@implementation CountryCodeSelectViewController

- (void)viewDidLoad {
    self.title = @"国家区号选择";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)dataListArray{
    if(!_dataListArray){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"AreaCode" ofType:@"plist"];
        _dataListArray = [[NSMutableArray alloc]initWithContentsOfFile:path];
    }
    return _dataListArray;
}

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate && UITableVIewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 27;
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
