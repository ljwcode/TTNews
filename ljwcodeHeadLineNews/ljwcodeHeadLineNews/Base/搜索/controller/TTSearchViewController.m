//
//  TTSearchViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTSearchViewController.h"
#import "TTArticleSearchInboxFourWordsModel.h"
#import "TTArticleSearchHistoryHeaderCell.h"
#import <TTNews-Swift.h>
#import "homeViewController.h"


@interface TTSearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,UITextFieldDelegate,searchEntranceBarViewDelegate>

@property(nonatomic,strong)NSMutableArray *searchHistoryArray;

@property(nonatomic,strong)NSMutableArray *recommendSearchArray;

@property(nonatomic,strong)UICollectionView *collectioneView;

@property(nonatomic,assign)BOOL showSearchHistory;

@property(nonatomic,assign)BOOL removeSpaceOnSearchString;

@property(nonatomic,assign)UIDeviceOrientation currentOrientation;

@property(nonatomic,strong)TTArticleSearchInboxFourWordsModel *searchKeyWordModel;

@property(nonatomic,strong)TTSearchEntranceBarView *entranceBarView;

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

-(TTSearchEntranceBarView *)entranceBarView{
    if(!_entranceBarView){
        _entranceBarView = [[TTSearchEntranceBarView alloc]initWithFrame:CGRectMake(0, [TTScreen TT_isPhoneX] ? 44 : 20, kScreenWidth, 44)];
        _entranceBarView.searchTextField.delegate = self;
        _entranceBarView.delegate = self;
    }
    return _entranceBarView;
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

-(UICollectionView *)collectioneView{
    if(!_collectioneView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectioneView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectioneView.delegate = self;
        _collectioneView.dataSource = self;
    }
    return _collectioneView;
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
    
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark ------- UICollectionViewDelegate && UICollectionViewDataSource



#pragma mark ------- UICollectionViewDelegateFlowLayout



#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

#pragma mark -------- searchEntranceBarViewDelegate

-(void)TT_EntranceBackHandle{
    [self dismissViewControllerAnimated:YES completion:nil];
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
