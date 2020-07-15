//
//  NewsChannelView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "NewsChannelView.h"
#import "newsChannelTitleView.h"
#import "newsChannelModel.h"
#import "ljwcodeHeader.h"
#import "channelButton.h"

@interface channelHeaderView : UIView

@end

@implementation channelHeaderView

@end

static CGFloat lineSpace = 10;//纵向间距
static CGFloat itemSpace = 10;//横向间距
static int columns = 4;
static CGFloat labelHeight = 40;

@interface NewsChannelView()<UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *myChannelArray;

@property (nonatomic,strong)NSMutableArray *recommendChannelArray;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,assign)CGFloat labelWidth;

@property(nonatomic,assign)CGRect headerViewOne_frame;

@property(nonatomic,strong)newsChannelTitleView *channelHeaderViewOne;

@property(nonatomic,strong)newsChannelTitleView *channelHeaderViewTwo;

@property(nonatomic,strong)newsChannelModel *newsModel;

@end

@implementation NewsChannelView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _myChannelArray = [[NSMutableArray alloc]initWithArray:@[@"推荐",@"热点",@"广州",@"视频",
                                                               @"社会",@"图片",@"娱乐",@"问答",
                                                               @"科技",@"汽车",@"财经",@"军事",
                                                               @"体育",@"段子",@"国际",@"趣图",
                                                               @"健康",@"特卖",@"房产",@"小说",
                                                               @"时尚",@"直播",@"育儿",@"搞笑",]];
        _recommendChannelArray = [[NSMutableArray alloc]initWithArray:@[@"历史",@"数码",@"美食",@"养生",
                                                                        @"电影",@"手机",@"旅游",@"宠物",
                                                                        @"情感",@"家具",@"教育",@"三农",
                                                                        @"孕产",@"文化",@"游戏",@"股票",
                                                                        @"科学",@"动漫",@"故事",@"收藏",
                                                                        @"精选",@"语录",@"星座",@"美图",
                                                                        @"辟谣",@"中国新唱将",@"微头条",@"正能量",
                                                                        @"互联网法院",@"彩票",@"快乐男声",@"中国好表演",
                                                                        @"传媒"]];
        [self setupUI];
        _labelWidth = (self.frame.size.width - itemSpace * (columns + 1)) / columns;
        _dataArray = [[NSMutableArray alloc]init];
        self.delegate = self;
        [self configureData];
       
    }
    return self;
}

-(void)setupUI
{
    newsChannelTitleView *channelHeaderOneView = [[newsChannelTitleView alloc]initWithTitle:@"我的频道" subTitle:@"点击进入频道" needEdit:YES];
    channelHeaderOneView.frame = CGRectMake(0, 40, self.frame.size.width, 54);
    _channelHeaderViewOne = channelHeaderOneView;
    
    [channelHeaderOneView setCallBack:^(BOOL selected) {
        [self refreshEditBtnStatus:selected];
    }];
    _headerViewOne_frame = channelHeaderOneView.frame;
    [self addSubview:_channelHeaderViewOne];
    
    newsChannelTitleView *channelHeaderTwoView = [[newsChannelTitleView alloc]initWithTitle:@"推荐频道" subTitle:@"点击进入频道" needEdit:NO];
    _channelHeaderViewTwo = channelHeaderTwoView;
    _channelHeaderViewTwo.frame = _channelHeaderViewTwo.bounds;
    _channelHeaderViewTwo.hidden = YES;
    [self addSubview:_channelHeaderViewTwo];
    
    newsChannelTitleView *headerTitleView = [[newsChannelTitleView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    [headerTitleView setCallBack:^(BOOL selected) {
        [self channelHide];
    }];
    [self addSubview:headerTitleView];
    
    self.backgroundColor = [UIColor whiteColor];
}

//设置数据源
-(void)configureData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for(int i = 0;i < _myChannelArray.count;i++){
            newsChannelModel *newsModel1 = [[newsChannelModel alloc]init];
            newsModel1.name = _myChannelArray[i];
            newsModel1.isMyChannel = YES;
            [self.dataArray addObject:newsModel1];
        }
        for(int i = 0;i < _recommendChannelArray.count;i++)
        {
            newsChannelModel *newsModel2 = [[newsChannelModel alloc]init];
            newsModel2.name = _recommendChannelArray[i];
            newsModel2.isMyChannel = NO;
            [self.dataArray addObject:newsModel2];//dataArray数组保存model里面的数据
        }
        [self refreshFrame];
    });
}

-(void)refreshFrame{
    
    for(int i = 0;i < _dataArray.count;i++){
        newsChannelModel *model = _dataArray[i];
        model.tag = i;
        if(model.isMyChannel){
            model.frame = isMyChannelFrame(i);
            self.newsModel = model;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.channelHeaderViewTwo.top = CGRectGetMaxY(self.newsModel.frame)+lineSpace;
        self.channelHeaderViewTwo.hidden = NO;
    });
    
    for(int i = 0;i < self.dataArray.count;i++)
    {
        newsChannelModel *model = self.dataArray[i];
        if(!model.isMyChannel){
            int index = i - self.newsModel.tag - 1;
            model.frame = isRecomChannelFrame(index);
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for(newsChannelModel *model in self.dataArray){
            
           __block channelButton *channelBtn = [[channelButton alloc]initWithMyChannelBlock:^(channelButton * _Nonnull Btn) {
                if(!channelBtn.deleteImageView.hidden){
                    [self removeChannelBtn:Btn]; //在我的频道那里进行删除操作
                }
            } recommendChannelBlock:^(channelButton * _Nonnull Btn) {
                [self addChannelBtn:Btn];//在推荐频道进行添加操作
            }];
            
            [channelBtn longPressGestureWithChannelBeginBlock:^(channelButton * _Nonnull Btn) {
                [self addSubview:Btn];

            } channelMoveBlock:^(channelButton * _Nonnull Btn, UILongPressGestureRecognizer * _Nonnull longPreGes) {
                [self adjustCenterForBtn:Btn withGes:longPreGes];
            } channelEndBlock:^(channelButton * _Nonnull Btn) {
                [self resetFrame:Btn];
            }];
            channelBtn.channelModel = model;
            if (channelBtn.channelModel.name.length > 2) {
                channelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
}
            if (model.tag == self.dataArray.count - 1) {
                self.contentSize = CGSizeMake(0, CGRectGetMaxY(model.frame) + 30);
            }
            [self addSubview:channelBtn];
        }
    });
}

#pragma mark - 添加，删除，移动channel Button

-(void)addChannelBtn:(channelButton *)btn{
    [self.dataArray removeObject:btn.channelModel];
    [self.dataArray insertObject:btn.channelModel atIndex:self.newsModel.tag+1];
    
    btn.channelModel.isMyChannel = YES;
    NSInteger newsModelIndex = self.newsModel.tag + 1;
    BOOL isEditSelected = self.channelHeaderViewOne.editButton.hidden;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for(int i = 0;i<self.dataArray.count;i++){
            newsChannelModel *model = self.dataArray[i];
            model.tag = i;
            if(model.isMyChannel){
                model.Btn.frame = isMyChannelFrame(i);
                model.hideDeleteBtn = isEditSelected?NO:YES;
            }else {
                NSInteger index = i - self.newsModel.tag -1;
                model.Btn.frame = isRecomChannelFrame(index);
                model.hideDeleteBtn = YES;
            }
            if(i == newsModelIndex){
                _newsModel = model;
            }
        }
        [self refreshData];
    });
     
}
//移除channelbutton
-(void)removeChannelBtn:(channelButton *)btn{
    
    [self.dataArray removeObject:btn.channelModel];
    [self.dataArray insertObject:btn.channelModel atIndex:self.newsModel.tag];
    
    btn.channelModel.isMyChannel = NO;
    NSInteger newsModelIndex = self.newsModel.tag - 1;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < self.dataArray.count; i++) {
            newsChannelModel *model = self.dataArray[i];
            model.tag = i;
            if(model.isMyChannel){
                model.Btn.frame = isMyChannelFrame(i);
                model.hideDeleteBtn = NO;
            }else {
                NSInteger index = i - self.newsModel.tag - 1;
                model.Btn.frame = isRecomChannelFrame(index);
                model.hideDeleteBtn = YES;
            }
            if(i == newsModelIndex){
                _newsModel = model;
            }
        }
        [self refreshData];
    });
}


//刷新数据
-(void)refreshData{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (newsChannelModel *model in _dataArray) {
            model.Btn.frame = model.frame;
            model.Btn.deleteImageView.hidden = model.hideDeleteBtn;
            [model.Btn reloadData];
        }
    });
}

//刷新headerViewTwo的frame
-(void)refreshChannelHeaderViewTwoFrame{
    if(self.channelHeaderViewTwo.hidden){
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.channelHeaderViewTwo.frame = CGRectMake(0, CGRectGetMaxY(self.newsModel.frame)+lineSpace, self.frame.size.width, 54);
    }];
    
}

-(void)setNewsModel:(newsChannelModel *)newsModel{
    _newsModel = newsModel;
    dispatch_main_async_safe(^{
        [self refreshChannelHeaderViewTwoFrame];
    });
}

#pragma mark - show && hide

- (void)channelShow {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height == 812?44:20, self.width, self.height);
    }];
}

- (void)channelHide {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, self.height, self.width, self.height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 刷新编辑按钮状态
//YES:NO
-(void)refreshEditBtnStatus:(BOOL)show{
    if(!show){
        for(channelButton *btn in self.subviews){
            if(![btn isKindOfClass:[channelButton class]])continue;
            if(!btn.channelModel.isMyChannel){
                btn.deleteImageView.hidden = YES;
            }else{
                btn.deleteImageView.hidden = YES;
            }
        }
    }else{
        for(channelButton *btn in self.subviews){
            if(![btn isKindOfClass:[channelButton class]])continue;
            if(!btn.channelModel.isMyChannel){
                btn.deleteImageView.hidden = YES;
            }else{
                btn.deleteImageView.hidden = NO;
            }
        }
    }
}

#pragma mark - channel button 交换位置

/*
 重置位置
 */
-(void)resetFrame:(channelButton *)Btn{
    
    newsChannelModel *model = Btn.channelModel;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        model.frame = isMyChannelFrame(Btn.channelModel.tag);
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                Btn.frame = model.frame;
            }];
        });
    });
}

-(void)newLocationTapWithBtn:(channelButton *)Btn locationBlock:(void(^)(newsChannelModel *model))localtionBlock{
    newsChannelModel *channelModel = Btn.channelModel;
    CGPoint moveBtnCenter = Btn.center;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *models = [[NSMutableArray alloc]initWithArray:self.dataArray];
        for (newsChannelModel *model in models) {
            if (model == channelModel) {
                continue;
            }
            if (!model.isMyChannel) {
                continue;
            }
            if (CGRectContainsPoint(model.frame,moveBtnCenter)) {
                localtionBlock(model);
            }
        }
    });
}

/*
 交换两个按钮位置
 */
- (void)adjustCenterForBtn:(channelButton *)Btn withGes:(UILongPressGestureRecognizer *)longPreGes{
    CGPoint newPoint = [longPreGes locationInView:self];
    Btn.center = newPoint;
    [self newLocationTapWithBtn:Btn locationBlock:^(newsChannelModel* targetModel) {
        if (self.newsModel == Btn.channelModel) {
            newsChannelModel *model = self.dataArray[Btn.channelModel.tag - 1];
            _newsModel = model;
        }else if(_newsModel == targetModel){
            _newsModel = Btn.channelModel;
        }
        [_dataArray removeObject:Btn.channelModel];
        [_dataArray insertObject:Btn.channelModel atIndex:targetModel.tag];
        for(int i = 0;i < _dataArray.count;i++){
            newsChannelModel *model = _dataArray[i];
            model.tag = i;
            if(model.isMyChannel && model != Btn.channelModel){
                model.frame = isMyChannelFrame(i);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for(int i = 0;i < _dataArray.count;i++){
                newsChannelModel *model = _dataArray[i];
                if(model.isMyChannel && model != Btn.channelModel){
                    [UIView animateWithDuration:0.25 animations:^{
                        Btn.channelModel.frame = model.frame;
                    }];
                }
            }
        });
    }];
    
    
}

#pragma mark - scrollerVIew delegate
/*
  向上滑动时隐藏channelView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y < -50){
        [self channelHide];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
