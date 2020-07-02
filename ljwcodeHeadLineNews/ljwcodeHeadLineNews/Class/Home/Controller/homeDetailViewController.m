//
//  homeDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeDetailViewController.h"
#import "homeNewsTableViewCell.h"
#import "homejokeTableViewCell.h"
#import "homeContentNewsTableViewCell.h"
#import "homeNewsModel.h"
#import "homeNewsCellViewModel.h"
#import "homeJokeModel.h"
#import "ljwcodeHeader.h"
#import "homeNewsBrowserViewController.h"

@interface homeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *detailTableView;

@property(nonatomic,strong)homeNewsCellViewModel *newsCellViewModel;

@property(nonatomic,strong)NSMutableArray *datasArray;

@end

@implementation homeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.detailTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.newsCellViewModel.newsCellViewCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.datasArray removeAllObjects];
            NSArray *datasArray = [self modelArrayWithCategory:self.titleModel.category fromModel:x];
            [self.datasArray addObjectsFromArray:datasArray];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
            [self.detailTableView.mj_footer endRefreshing];
        }];
    }];
    [self.detailTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

-(NSArray *)modelArrayWithCategory:(NSString *)category fromModel:(id)model{
    if([category isEqualToString:@"essay_joke"]){
        homeJokeModel *jokeModel = (homeJokeModel *)model;
        return jokeModel.data_array;
    }else if([category isEqualToString:@"组图"]){
        homeNewsModel *newsModel = (homeNewsModel *)model;
        return newsModel.data;;
    }else{
        homeNewsModel *newsModel = (homeNewsModel *)model;
        return newsModel.data;
    }
}

-(NSMutableArray *)datasArray{
    if(!_datasArray){
        _datasArray = [[NSMutableArray alloc]init];
    }
    return _datasArray;
}

-(homeNewsCellViewModel *)newsCellViewModel{
    if(!_newsCellViewModel){
        _newsCellViewModel = [[homeNewsCellViewModel alloc]init];
    }
    return _newsCellViewModel;
}

-(UITableView *)detailTableView{
    
    if(!_detailTableView){
        
        UITableView *tableView = [[UITableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 152;
        tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        //设置UITableViewCell
        
        UINib *newsTableViewCell = [UINib nibWithNibName:NSStringFromClass([homeNewsTableViewCell class]) bundle:nil];
        [tableView registerNib:newsTableViewCell forCellReuseIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
        
        UINib *jokeTableViewCell = [UINib nibWithNibName:NSStringFromClass([homejokeTableViewCell class]) bundle:nil];
        [tableView registerNib:jokeTableViewCell forCellReuseIdentifier:NSStringFromClass([homejokeTableViewCell class])];
        
        UINib *contentNewsCell = [UINib nibWithNibName:NSStringFromClass([homeContentNewsTableViewCell class]) bundle:nil];
        [tableView registerNib:contentNewsCell forCellReuseIdentifier:NSStringFromClass([homeContentNewsTableViewCell class])];
        _detailTableView = tableView;
    }
    return _detailTableView;
}

-(void)needRefreshTableViewData{
    [self.detailTableView setContentOffset:CGPointZero];
    [self.detailTableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultCell = nil;
    if([self.titleModel.category isEqualToString:@"essay_joke"]){
        homejokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homejokeTableViewCell class])];
        homeJokeSummarymodel *model = self.datasArray[indexPath.row];
        cell.jokeSummaryModel = model;
        resultCell = cell;
    }else if([self.titleModel.category isEqualToString:@"组图"]){
        homeNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
        homeNewsSummaryModel *model = self.datasArray[indexPath.row];
        cell.summaryModel = model;
        resultCell = cell;
    }else{
        homeNewsSummaryModel *model = self.datasArray[indexPath.row];
        if(model.infoModel.image_list){
            homeNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
            cell.summaryModel = model;
            resultCell = cell;
        }else{
            homeContentNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeContentNewsTableViewCell class])];
            cell.newsSummaryModel = model;
            resultCell = cell;
        }
    }
    return resultCell;
}

//点击news cell跳转到新闻显示界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    homeNewsSummaryModel *model = [[homeNewsSummaryModel alloc]init];
    homeNewsBrowserViewController *webVC = [[homeNewsBrowserViewController alloc]init];
    webVC.urlString = model.infoModel.article_url;
    [self.navigationController pushViewController:webVC animated:YES];
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
