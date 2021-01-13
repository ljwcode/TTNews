//
//  TTTabBarView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTTabBarView.h"
#import "TTItemButton.h"
#import "TT_tabBarViewModel.h"
#import "TT_tabBarModel.h"

@interface TTTabBarView()

@property(nonatomic,assign)NSInteger currentItem;

@property(nonatomic,strong)TT_tabBarViewModel *viewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TTTabBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.currentItem = 1000;
        [[self.viewModel.tabBarCommand execute:@"tabBar"]subscribeNext:^(id  _Nullable x) {
            [self.dataArray addObjectsFromArray:x];
        }];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TTFontChangeHandle) name:TT_ALL_FONT_CHANGE object:nil];
    }
    return self;
}

-(void)TT_itemButton:(NSInteger)itemCount itemBlock:(TTItemButtonBlock)itemBlock{
    CGFloat itemW = kScreenWidth / itemCount;
    CGFloat w = itemW / 2.0 - itemW / 2.0;
    for(int i = 0;i < itemCount;i++){
        TTItemButton *itemBtn = [TTItemButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setFrame:CGRectMake(w +itemW *i, 0, itemW, 66)];
        [itemBtn setTag:100 + i];
        TT_tabBarModel *model = self.dataArray[i];
        [itemBtn setTitle:model.titleName forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:model.normalImg] forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:model.selectedImg] forState:UIControlStateSelected];
        itemBtn.titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        [self addSubview:itemBtn];
    }
    self.block = itemBlock;
}

#pragma mark ----- ChangeFont
-(void)TTFontChangeHandle{
    for(int i = 0;i < self.dataArray.count;i++){
        TTItemButton *itemBtn = (TTItemButton *)[self viewWithTag:100 + i];
        itemBtn.titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    }
}

#pragma mark ----- lazy load
-(TT_tabBarViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[TT_tabBarViewModel alloc]init];
    }
    return _viewModel;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
