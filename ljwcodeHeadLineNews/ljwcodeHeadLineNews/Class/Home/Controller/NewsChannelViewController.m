//
//  NewsChannelViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "NewsChannelViewController.h"
#import "TTChannelMyHeaderView.h"
#import "TTChannelRecommendHeaderView.h"

static NSString *const TTChannelMyHeaderViewID = @"TTChannelMyHeaderView";
static NSString *const TTChannelRecommendHeaderViewID = @"TTChannelRecommendHeaderView";

@interface NewsChannelViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray *myChannelArray;

@property (nonatomic,strong)NSMutableArray *recommendChannelArray;

@property(nonatomic,strong)UIScrollView *TTPanelScrollView;

@property(nonatomic,strong)UICollectionView *myChannelCollectionView;

@property(nonatomic,strong)UICollectionView *recommendChannelCollectionView;

@property(nonatomic,assign)CGSize MyItemSize;

@property(nonatomic,assign)CGSize RecItemSize;

@end

@implementation NewsChannelViewController

-(void)viewDidLayoutSubviews{
    UIButton *closePopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closePopBtn setImage:[UIImage imageNamed:@"close_grade_small"] forState:UIControlStateNormal];
    [closePopBtn addTarget:self action:@selector(closePopHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closePopBtn];
    
    [closePopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hSpace);
        make.top.mas_equalTo(vSpace);
        make.width.height.mas_equalTo(30);
    }];
    
    UIButton *searchPopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchPopBtn setImage:[UIImage imageNamed:@"search_mine_tab"] forState:UIControlStateNormal];
    [searchPopBtn addTarget:self action:@selector(searchPopHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchPopBtn];
    
    [searchPopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(hSpace);
        make.top.mas_equalTo(vSpace);
        make.width.height.mas_equalTo(30);
    }];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}


#pragma mark ------- UICollectionViewDelegate && UICollectionViewDataSource

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.MyItemSize;
}


#pragma mark ------ lazy load

-(UIScrollView *)TTPanelScrollView{
    if(!_TTPanelScrollView){
        _TTPanelScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _TTPanelScrollView.showsVerticalScrollIndicator = NO;
        _TTPanelScrollView.showsHorizontalScrollIndicator = NO;
        _TTPanelScrollView.bounces = NO;
    }
    return _TTPanelScrollView;
}

-(UICollectionView *)myChannelCollectionView{
    if(!_myChannelCollectionView){
        self.MyItemSize = CGSizeMake(80, 30);
        UICollectionViewFlowLayout *myFloatLayout = [[UICollectionViewFlowLayout alloc]init];
        myFloatLayout.itemSize = self.MyItemSize;
        myFloatLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        myFloatLayout.minimumLineSpacing = (kScreenWidth - self.MyItemSize.width * 4)/5;
        myFloatLayout.minimumInteritemSpacing = vSpace/2;
        _myChannelCollectionView = [[UICollectionView alloc]init];
        _myChannelCollectionView.collectionViewLayout = myFloatLayout;
        _myChannelCollectionView.delegate = self;
        _myChannelCollectionView.dataSource = self;
        
        [_myChannelCollectionView registerNib:[UINib nibWithNibName:TTChannelMyHeaderViewID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TTChannelMyHeaderViewID];
    }
    return _myChannelCollectionView;
}

-(UICollectionView *)recommendChannelCollectionView{
    if(!_recommendChannelCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _recommendChannelCollectionView = [[UICollectionView alloc]init];
        _recommendChannelCollectionView.collectionViewLayout = layout;
        _recommendChannelCollectionView.showsHorizontalScrollIndicator = NO;
        _recommendChannelCollectionView.showsVerticalScrollIndicator = NO;
        _recommendChannelCollectionView.contentSize = CGSizeMake(hSpace/2 + (self.RecItemSize.width + hSpace/2) * self.recommendChannelArray.count, self.RecItemSize.height + vSpace);
        _recommendChannelCollectionView.delegate = self;
        _recommendChannelCollectionView.dataSource = self;
        [_recommendChannelCollectionView registerNib:[UINib nibWithNibName:TTChannelRecommendHeaderViewID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TTChannelRecommendHeaderViewID];
    }
    return _recommendChannelCollectionView;
}

#pragma mark ------ 响应事件

-(void)closePopHandle:(UIButton *)sender{
    
}

-(void)searchPopHandle:(UIButton *)sender{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
