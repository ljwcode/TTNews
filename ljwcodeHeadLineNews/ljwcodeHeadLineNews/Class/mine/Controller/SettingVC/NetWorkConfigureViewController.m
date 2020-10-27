//
//  NetWorkConfigureViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "NetWorkConfigureViewController.h"

@interface NetWorkConfigureViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NetWorkConfigureViewController

-(void)viewDidLayoutSubviews{
    self.title = @"网络设置";
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tta_backbutton_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma mark ------ UITableViewDelegate && UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *ResultCell = nil;
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = @"非WIFI网络流量";
            UIButton *tipBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.4, CGRectGetHeight(cell.frame))];
            [tipBtn setTitle:@"极省流量(不下载图)" forState:UIControlStateNormal];
            tipBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            tipBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [tipBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [tipBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
            tipBtn.imageEdgeInsets = UIEdgeInsetsMake(0, tipBtn.titleLabel.intrinsicContentSize.width, 0, -tipBtn.titleLabel.intrinsicContentSize.width);
            tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -tipBtn.imageView.intrinsicContentSize.width, 0, tipBtn.imageView.intrinsicContentSize.width);
            cell.accessoryView = tipBtn;
        }
        ResultCell = cell;
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = @"非WIFI网络播放提醒";
            UIButton *tipBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.25, CGRectGetHeight(cell.frame))];
            [tipBtn setTitle:@"提醒一次" forState:UIControlStateNormal];
            tipBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            tipBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [tipBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [tipBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
            tipBtn.imageEdgeInsets = UIEdgeInsetsMake(0, tipBtn.titleLabel.intrinsicContentSize.width, 0, -tipBtn.titleLabel.intrinsicContentSize.width);
            tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -tipBtn.imageView.intrinsicContentSize.width, 0, tipBtn.imageView.intrinsicContentSize.width);
            cell.accessoryView = tipBtn;
        }
        ResultCell = cell;
    }
    
    return ResultCell;
}

#pragma mark ------ lazy load

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark ----- 响应事件
-(void)backBarItemHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
