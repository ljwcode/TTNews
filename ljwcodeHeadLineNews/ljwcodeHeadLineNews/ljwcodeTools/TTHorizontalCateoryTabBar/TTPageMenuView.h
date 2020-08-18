//
//  TTPageMenuView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTPageMenuItem.h"

NS_ASSUME_NONNULL_BEGIN
@class TTPageMenuView,TTPageDecorateView;

@protocol TTPageMenuViewDataSource<NSObject>

@required

-(NSInteger)numberOfItemInMenuView:(TTPageMenuView *)menuView;

-(TTPageMenuItem *)menuView:(TTPageMenuView *)menuView menuCellForItemAtIndex:(NSInteger)index;

@optional

-(UIView *)decorateMenuView:(TTPageMenuView *)menuView;

@end

@protocol TTPageMenuViewDelegate<NSObject>

@optional
-(void)menuView:(TTPageMenuView *)menuView didSelectedAtIndex:(NSInteger)index;


@end

@interface TTPageMenuView : UIView<TTPageMenuViewDelegate>

@property(nonatomic,weak)id<TTPageMenuViewDelegate>delegate;

@property(nonatomic,weak)id<TTPageMenuViewDataSource>dataSource;

@property(nonatomic,weak)UICollectionView *menuCollectionView;

@property(nonatomic,assign)CGSize menuSize;

@property(nonatomic,assign)CGSize decorateSize;

@property(nonatomic,strong)UIColor *decorateColor;

-(void)selectedItemAtIndex:(NSInteger)index withAnimation:(BOOL)animation;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
