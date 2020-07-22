//
//  channelButton.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "channelButton.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

static UIBezierPath *drawBezierPath(channelButton *Btn){
    UIBezierPath *BezierPath = [UIBezierPath bezierPath];

    CGFloat width = Btn.frame.size.width;
    CGFloat height = Btn.frame.size.height;
    CGFloat x = Btn.frame.origin.x;
    CGFloat y = Btn.frame.origin.y;
    CGFloat halfWH = 2;

    CGPoint topLeft = Btn.frame.origin;
    CGPoint topMiddle = CGPointMake((x+width)/2, y-halfWH);
    CGPoint topRight =  CGPointMake(x+width, y);

    CGPoint rightMiddle = CGPointMake(x+width+halfWH, (y+height)/2);
    CGPoint rightBottom = CGPointMake(x+width, y+height);

    CGPoint bottomMiddle = CGPointMake((x+width)/2, y+height+halfWH);
    CGPoint bottomLeft = CGPointMake(x, y+height);

    CGPoint leftMiddle = CGPointMake(x-halfWH, (y+height)/2);
    [BezierPath moveToPoint:topLeft];
    [BezierPath addQuadCurveToPoint:topRight controlPoint:topMiddle];
    [BezierPath addQuadCurveToPoint:rightBottom controlPoint:rightMiddle];
    [BezierPath addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
    [BezierPath addQuadCurveToPoint:topLeft controlPoint:leftMiddle];

    return BezierPath;
}

static inline void configureChannelBtn(channelButton *Btn){
    Btn.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1];
    Btn.layer.shadowColor = nil;
    Btn.layer.shadowOffset = CGSizeMake(0, 0);
    Btn.layer.shadowPath = nil;
}

static inline void configureRecommendChannelBtn(channelButton *Btn){
    
    Btn.backgroundColor = [UIColor whiteColor];
    Btn.layer.shadowOffset = CGSizeMake(1, 1);
    Btn.layer.shadowOpacity = 0.2; //透明度
    Btn.layer.shadowColor = [UIColor blackColor].CGColor;
    Btn.layer.shadowPath = drawBezierPath(Btn).CGPath;
    
}

@interface channelButton()

@property(nonatomic,copy)void(^myChannelBlock)(channelButton *);

@property(nonatomic,copy)void(^recommendChannelBlock)(channelButton *);

@property(nonatomic,copy)void(^channelBeginBlock)(channelButton *);

@property(nonatomic,copy)void(^channelMoveBlock)(channelButton *,UILongPressGestureRecognizer *longPreGesture);

@property(nonatomic,copy)void(^channelEndBlock)(channelButton *);

@end

@implementation channelButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        UIImageView *delImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"closeicon_repost_18x18_"]];
        _deleteImageView = delImageView;
        [self addSubview:_deleteImageView];
        [_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(18);
            make.top.right.mas_equalTo(self);
        }];
        delImageView.hidden = YES;
        [self addTarget:self action:@selector(delBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
        self.layer.cornerRadius = 4.f;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        UILongPressGestureRecognizer *longPreGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPresHandle:)];
        [self addGestureRecognizer:longPreGes];
        [self reloadData];
    }
    return self;
}

-(void)delBtnHandle:(channelButton *)sender
{
    if(sender.channelModel.isMyChannel){
        if(self.myChannelBlock){
            self.myChannelBlock(sender);
        }
    }else{
        if(self.recommendChannelBlock){
            self.recommendChannelBlock(sender);
        }
    }
}

-(void)longPresHandle:(UILongPressGestureRecognizer *)longGes{
    if(self.channelModel.isMyChannel == NO || self.deleteImageView.hidden == NO){
        return;
    }
    switch(longGes.state){
            
        case UIGestureRecognizerStateBegan:
        {
            CGPoint center = self.center;
            [UIView animateWithDuration:0.25 animations:^{
                self.width = self.width + 10;
                self.height = self.height + 8;
                self.center = center;
            }];
            if(self.channelBeginBlock){
                self.channelBeginBlock(self);
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            if(self.channelMoveBlock){
                self.channelMoveBlock(self, longGes);
            }
            break;
        case UIGestureRecognizerStateEnded:
            if(self.channelEndBlock){
                self.channelEndBlock(self);
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if(self.channelEndBlock){
                self.channelEndBlock(self);
            }
            break;
        case UIGestureRecognizerStatePossible:
            
            break;
        case UIGestureRecognizerStateFailed:
            
            break;
    }
    
}

//刷新channelItem的显示内容
-(void)reloadData{
    if(self.channelModel.isMyChannel){
        [self setTitle:self.channelModel.name forState:UIControlStateNormal];
        configureChannelBtn(self);
    }else{
        [self setTitle:[NSString stringWithFormat:@"+%@",self.channelModel.name] forState:UIControlStateNormal];
        configureRecommendChannelBtn(self);
    }
}

-(void)setChannelModel:(newsChannelModel *)channelModel{
    _channelModel = channelModel;
    self.frame = channelModel.frame;
    channelModel.Btn = self;
    if(channelModel.isMyChannel){
        [self setTitle:channelModel.name forState:UIControlStateNormal];
        configureChannelBtn(self);
    }else{
        [self setTitle:[NSString stringWithFormat:@"+%@",channelModel.name] forState:UIControlStateNormal];
        configureRecommendChannelBtn(self);
    }
}

-(instancetype)initWithMyChannelBlock:(void (^)(channelButton * _Nonnull))channelBlock recommendChannelBlock:(void (^)(channelButton * _Nonnull))recommendChannelBlock{
    if(self = [super init]){
        _myChannelBlock = channelBlock;
        _recommendChannelBlock = recommendChannelBlock;
    }
    return self;
}

-(void)longPressGestureWithChannelBeginBlock:(void (^)(channelButton * _Nonnull))channelBeginBlock channelMoveBlock:(void (^)(channelButton * _Nonnull,UILongPressGestureRecognizer *longPreGes))channelMoveBlock channelEndBlock:(void (^)(channelButton * _Nonnull))channelEndBlock
{
    _channelBeginBlock = channelBeginBlock;
    _channelMoveBlock = channelMoveBlock;
    _channelEndBlock = channelEndBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
