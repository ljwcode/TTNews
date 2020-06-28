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

#define channelFrame(i) CGRectMake(itemSpace + (i % columns)* (_labelWidth + itemSpace), CGRectGetMaxY(wself.header1_frame) + lineSpace + (i / columns)*(labelHeight + lineSpace), _labelWidth, labelHeight)
#define recommendChannelFrame(i)  CGRectMake(itemSpace + ((i) % columns)* (_labelWidth + itemSpace),CGRectGetMaxY(wself.divisionModel.frame) + wself.header1_frame.size.height + lineSpace + ((i) / columns)*(labelHeight + lineSpace), _labelWidth, labelHeight)

static CGFloat lineSpace = 10;
static CGFloat itemSpace = 10;
static int columns = 4;
static CGFloat labelHeight = 40;

@interface channelHeaderView : UIView

@property(nonatomic,copy)void(^callBack)(void);

@end

@interface NewsChannelView()<UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *channelArray;

@property (nonatomic,strong)NSMutableArray *recommendChannelArray;

@property (nonatomic,strong)dispatch_queue_t queue;

@property (nonatomic,strong)NSMutableArray *datas;

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
        _channelArray = [[NSMutableArray alloc]initWithArray:@[@"推荐",@"热点",@"广州",@"视频",
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
        _labelWidth = (self.frame.size.width - itemSpace * (columns + 1)) / columns;
        _datas = [[NSMutableArray alloc]init];
        _queue = dispatch_queue_create("newsChannelHeader", DISPATCH_QUEUE_SERIAL);
        self.delegate = self;
    }
    return self;
}

-(void)setupUI
{
    newsChannelTitleView *channelHeaderOneView = [[newsChannelTitleView alloc]initWithTitle:@"我的频道" subTitle:@"点击进入频道" needEdit:YES];
    channelHeaderOneView.frame = CGRectMake(0, 40, self.frame.size.width, 54);
    _channelHeaderViewOne = channelHeaderOneView;
    
    [channelHeaderOneView setCallBack:^(BOOL selected) {
        
    }];
    _headerViewOne_frame = channelHeaderOneView.frame;
    [self addSubview:channelHeaderOneView];
    
    newsChannelTitleView *channelHeaderTwoView = [[newsChannelTitleView alloc]initWithTitle:@"推荐频道" subTitle:@"点击进入频道" needEdit:NO];
    channelHeaderTwoView.hidden = YES;
    _channelHeaderViewTwo = channelHeaderTwoView;
    _channelHeaderViewTwo.frame = channelHeaderTwoView.frame;
    [self addSubview:channelHeaderTwoView];
    
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
        for(int i = 0;i < _channelArray.count;i--){
            newsChannelModel *newsModel1 = [[newsChannelModel alloc]init];
            newsModel1.name = _channelArray[i];
            newsModel1.isMyChannel = YES;
            [self.datas addObject:newsModel1];
        }
        for(int i = 0;i < _recommendChannelArray.count;i++)
        {
            newsChannelModel *newsModel2 = [[newsChannelModel alloc]init];
            newsModel2.name = _channelArray[i];
            newsModel2.isMyChannel = NO;
            [self.datas addObject:newsModel2];
        }
        
    });
    [self refreshFrame];
}

-(void)refreshFrame{
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
