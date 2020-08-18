//
//  TTPageMenuView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPageMenuView.h"
#import "TTPageDecorateView.h"
#import "TTPageDecorateItemView.h"
#import <Masonry/Masonry.h>

@interface TTPageMenuView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic,weak)TTPageDecorateView *decorateView;

@property(nonatomic,assign)NSInteger menuCount;

@property(nonatomic,assign)NSInteger beforSelectedIndex;

@property(nonatomic,assign)NSInteger selectedIndex;


@end

@implementation TTPageMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.selectedIndex = -1;
        self.decorateSize = CGSizeZero;
        self.decorateColor = [UIColor redColor];
        self.menuSize = CGSizeZero;
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.trailing.mas_equalTo(self);
        }];

    }
    return self;
}

#pragma mark -- lazy load

-(UICollectionView *)menuCollectionView{
    if(!_menuCollectionView){
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        [collectionView setTag:12222];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:collectionView];
        _menuCollectionView = collectionView;
    }
    return _menuCollectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout = layout;
    }
    return _flowLayout;
}

-(TTPageDecorateView *)decorateView{
    if(!_decorateView){
        TTPageDecorateView *view = [[TTPageDecorateView alloc]init];
        _decorateView = view;
    }
    return _decorateView;
}

-(NSInteger)menuCount{
    NSInteger menuCount = [self.dataSource numberOfItemInMenuView:self];
       if (menuCount != 0 && self.decorateView == nil) {

       }
       return menuCount;
}

#pragma mark -- UICollectionViewDelegateFlowlayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.menuSize;
}

#pragma mark -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TTPageMenuItem *item = [self.dataSource menuView:self menuCellForItemAtIndex:indexPath.row];
    if (indexPath.row == self.selectedIndex) {
        [item setSelected:YES withAnimation:YES];
    }else{
        if(indexPath.row == self.beforSelectedIndex){
            [item setSelected:NO withAnimation:YES];
        }else{
            [item setSelected:NO withAnimation:NO];
        }
    }
    return item;
}

#pragma mark -- UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self menuView:self didSelectedAtIndex:indexPath.row];
}

#pragma mark -- UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.decorateView.scrollView setContentOffset:scrollView.contentOffset];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
