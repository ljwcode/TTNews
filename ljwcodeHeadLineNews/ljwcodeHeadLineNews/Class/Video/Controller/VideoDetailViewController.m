//
//  VideoDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "TVVideoPlayerViewCell.h"
#import "shortVideoPlayerViewCell.h"
#import "videoContentViewModel.h"

@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation VideoDetailViewController

-(videoContentViewModel *)contentViewModel{
    if(!_contentViewModel){
        _contentViewModel = [[videoContentViewModel alloc]init];
    }
    return _contentViewModel;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray  = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UINib *TVNib = [UINib nibWithNibName:NSStringFromClass([TVVideoPlayerViewCell class]) bundle:nil];
        [_tableView registerNib:TVNib forCellReuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        
        UINib *shortVideoNib = [UINib nibWithNibName:NSStringFromClass([shortVideoPlayerViewCell class]) bundle:nil];
        [_tableView registerNib:shortVideoNib forCellReuseIdentifier:NSStringFromClass([shortVideoPlayerViewCell class])];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)needRefreshTableViewData{
    [self.tableView setContentOffset:CGPointZero];
    [self.tableView.mj_header beginRefreshing];
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
