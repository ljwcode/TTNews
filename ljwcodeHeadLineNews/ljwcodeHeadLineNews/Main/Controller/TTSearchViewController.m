//
//  TTSearchViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTSearchViewController.h"
#import "TTArticleSearchInboxFourWordsCell.h"
#import "TTArticleSearchInboxFourWordsModel.h"
#import "TTArticleSearchHeaderCell.h"
#import "TTArticleSearchTagCell.h"
#import "TTArticleSearchCell.h"
#import <TTNews-Swift.h>


@interface TTSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray *searchHistoryArray;

@property(nonatomic,strong)NSMutableArray *recommendSearchArray;

@property(nonatomic,strong)UITableView *baseSearchTableView;

@property(nonatomic,assign)BOOL showSearchHistory;

@property(nonatomic,assign)BOOL removeSpaceOnSearchString;

@property(nonatomic,assign)UIDeviceOrientation currentOrientation;

@property(nonatomic,strong)TTArticleSearchInboxFourWordsModel *searchKeyWordModel;

@property(nonatomic,strong)SearchEntranceBarView *entranceBarView;

@end

@implementation TTSearchViewController

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}


-(void)loadView{
    [super loadView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.showSearchHistory = YES;
    [self.entranceBarView.searchTextField becomeFirstResponder];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    
    [self.view addSubview:self.entranceBarView];
    
    self.baseSearchTableView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.baseSearchTableView.layer.borderWidth = 2.f;
    [self.view addSubview:self.baseSearchTableView];
    [self.baseSearchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.entranceBarView.mas_bottom).offset(0);
        make.height.mas_equalTo(kScreenHeight);
    }];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark - lazy load

-(SearchEntranceBarView *)entranceBarView{
    if(!_entranceBarView){
        _entranceBarView = [[SearchEntranceBarView alloc]initWithFrame:CGRectMake(0, [TTScreen TT_isPhoneX] ? 44 : 20, kScreenWidth, 44)];
        _entranceBarView.searchTextField.delegate = self;
    }
    return _entranceBarView;
}

-(UITableView *)baseSearchTableView{
    if(!_baseSearchTableView){
        _baseSearchTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _baseSearchTableView.delegate = self;
        _baseSearchTableView.dataSource = self;
        _baseSearchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UINib *tagCell = [UINib nibWithNibName:NSStringFromClass([TTArticleSearchTagCell class]) bundle:nil];
        [_baseSearchTableView registerNib:tagCell forCellReuseIdentifier:NSStringFromClass([TTArticleSearchTagCell class])];
        [_baseSearchTableView registerClass:[TTArticleSearchInboxFourWordsCell class] forCellReuseIdentifier:NSStringFromClass([TTArticleSearchInboxFourWordsCell class])];
        [_baseSearchTableView registerClass:[TTArticleSearchHeaderCell class] forCellReuseIdentifier:NSStringFromClass([TTArticleSearchHeaderCell class])];
        [_baseSearchTableView registerClass:[TTArticleSearchCell class] forCellReuseIdentifier:NSStringFromClass([TTArticleSearchCell class])];
        [_baseSearchTableView registerClass:[TTSearchLynxViewCell class] forCellReuseIdentifier:NSStringFromClass([TTSearchLynxViewCell class])];
        if (@available(iOS 15.0, *)) {
            _baseSearchTableView.sectionHeaderTopPadding = 0;
        }
    }
    return _baseSearchTableView;
}

-(NSMutableArray *)searchHistoryArray{
    if(!_searchHistoryArray){
        _searchHistoryArray = [[NSMutableArray alloc]init];
    }
    return _searchHistoryArray;
}

-(NSMutableArray *)recommendSearchArray{
    if(!_recommendSearchArray){
        _recommendSearchArray = [[NSMutableArray alloc]init];
    }
    return _recommendSearchArray;
}

-(TTArticleSearchInboxFourWordsModel *)searchKeyWordModel{
    if(!_searchKeyWordModel){
        _searchKeyWordModel = [[TTArticleSearchInboxFourWordsModel alloc]init];
    }
    return _searchKeyWordModel;
}

#pragma mark - 事件响应

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.entranceBarView.searchTextField resignFirstResponder];
}

#pragma mark --收起键盘
// 滑动空白处隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

// 点击空白处收键盘
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

-(BOOL)disablesAutomaticKeyboardDismissal{
    return NO;
}

#pragma mark ---- UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textField = %@",textField.text);
    [self.searchHistoryArray addObject:textField.text];
    self.showSearchHistory = YES;
    [self.baseSearchTableView reloadData];
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.showSearchHistory == YES ? 4 : 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return self.showSearchHistory == YES ? (self.searchHistoryArray.count % 2 == 1 ? self.searchHistoryArray.count/2 + 1 : self.searchHistoryArray.count/2) : 0;
    }else if(section == 3){
        return self.showSearchHistory == YES ? 1 : 0;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *ResultCell = nil;
    if(indexPath.section == 0){
        TTArticleSearchInboxFourWordsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTArticleSearchInboxFourWordsCell class])];
        cell.backgroundColor = [UIColor clearColor];
        if(!cell){
            cell = [[TTArticleSearchInboxFourWordsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTArticleSearchInboxFourWordsCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"recommandSearchWords"];
        cell.searchWordsArray = array;
        ResultCell = cell;
    }else if(indexPath.section == 1){
        TTArticleSearchHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTArticleSearchHeaderCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(!cell){
            cell = [[TTArticleSearchHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTArticleSearchHeaderCell class])];
        }
        ResultCell = cell;
    }else if(indexPath.section == 2){
        if(self.showSearchHistory){
            TTArticleSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTArticleSearchCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if(!cell){
                cell = [[TTArticleSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTArticleSearchCell class])];
            }
            cell.searchHistoryArray = self.searchHistoryArray[indexPath.row];
            ResultCell = cell;
        }else{
            TTSearchLynxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTSearchLynxViewCell class])];
            if(!cell){
                cell = [[TTSearchLynxViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTSearchLynxViewCell class])];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ResultCell = cell;
        }
    }else if(indexPath.section == 3){
        TTSearchLynxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTSearchLynxViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(!cell){
            cell = [[TTSearchLynxViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTSearchLynxViewCell class])];
        }
        ResultCell = cell;
    }
    return ResultCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    view.backgroundColor = [UIColor redColor];
    return  view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    view.backgroundColor = [UIColor purpleColor];
    return  view;;
}

#pragma mark - UITableViewdelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
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
