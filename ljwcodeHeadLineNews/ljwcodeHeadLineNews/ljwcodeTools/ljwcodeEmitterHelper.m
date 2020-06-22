//
//  ljwcodeEmitterHelper.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/20.
//  Copyright © 2020 melody. All rights reserved.
//

#import "ljwcodeEmitterHelper.h"

@interface ljwcodeEmitterHelper()

@property(nonatomic,weak)CAEmitterLayer *layer;
@property(nonatomic,strong)NSMutableArray *array;

@end

static ljwcodeEmitterHelper *instance = nil;
static CGFloat emitterTimer = 5;

@implementation ljwcodeEmitterHelper

+(ljwcodeEmitterHelper *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ljwcodeEmitterHelper alloc]init];
    });
    
    return instance;
}

-(instancetype)init
{
    if(self = [super init])
    {
        [self configure];
    }
    return self;
}

-(void)configure
{
    for(int i=0;i<=emitterTimer;i++)
    {
        CAEmitterCell *cell = [[CAEmitterCell alloc]init];
        cell.name = [NSString stringWithFormat:@"emitterCell_%d",i];
        cell.alphaRange     = 0.5;
        cell.alphaSpeed     = -0.5;
        cell.lifetime       = 4;
        cell.lifetimeRange  = 2;
        cell.velocity       = 600;
        cell.birthRate      = 150;
        cell.velocityRange  = 200.00;
        cell.scale          = 0.5;
        cell.yAcceleration = 600;
        cell.emissionLongitude = 2 *M_PI - M_PI /4.0;
        cell.emissionRange = M_PI / 2.0;
        [self.array addObject:cell];
    }
}

+(NSArray<UIImage *>*)defaultImage
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i=0;i<emitterTimer;i++)
    {
        int x = arc4random()%100+1;
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%03d",x]];
        [arr addObject:image];
    }
    
    return arr;
}

-(NSMutableArray *)array
{
    if(!_array)
    {
        _array = [[NSMutableArray alloc]init];
    }
    return _array;
}

-(void)setLongPressGreView:(UIView *)longPressGreView
{
    _longPressGreView = longPressGreView;
    UILongPressGestureRecognizer *longGesrec = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longGesrec.minimumPressDuration = 0.5;
    [_longPressGreView addGestureRecognizer:longGesrec];
}

-(void)showEmitterCellWithImage:(NSArray<UIImage *> *)image isShock:(BOOL)shock onView:(UIView *)view
{
    for(int i=0;i<image.count;i++)
    {
        CAEmitterCell *cell = [[CAEmitterCell alloc]init];
        cell.contents = (__bridge id)(image[i].CGImage);
    }
    CAEmitterLayer *emitterLayer = [[CAEmitterLayer alloc]init];
    emitterLayer.name = @"emitterLayer";
    emitterLayer.position = CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    emitterLayer.emitterCells = self.array;
    [view.layer addSublayer:emitterLayer];
}

-(void)stopEmitterAnimation:(id)obj
{
    for(int i=0;i<=emitterTimer;i++)
    {
        [obj setValue:@0 forKey:@"EmitterCells.emitterCell_%d.birthRate"];
    }
}

-(void)longPress:(UILongPressGestureRecognizer *)gesRec
{
    //手势开始
    if (gesRec.state == UIGestureRecognizerStateBegan) {
        CAEmitterLayer *layer = [CAEmitterLayer layer];//创建粒子效果，位置，显示效果图片
        layer.name = @"emitterLayer";
        layer.position  = CGPointMake(gesRec.view.frame.size.width/2.0, gesRec.view.frame.size.height/2.0);
        NSArray *images =  [[self class] defaultImage];
        for (int i = 0; i<images.count; i++) {//粒子显示效果图片
            CAEmitterCell *cell = self.array[i];
            cell.contents = CFBridgingRelease([images[i] CGImage]);
        }
        layer.emitterCells = self.array;
        [gesRec.view.layer addSublayer:layer];
        layer.beginTime = CACurrentMediaTime();
        for (int i = 0; i < emitterTimer; i++) {
            [layer setValue:@(emitterTimer) forKeyPath:[NSString stringWithFormat:@"emitterCells.explosion_%d.birthRate",i]];
        }
        _layer = layer;
    //手势结束/手势取消
    }else if (gesRec.state == UIGestureRecognizerStateEnded || gesRec.state == UIGestureRecognizerStateCancelled){
        [self stopEmitterAnimation:_layer];//取消动画效果
    }
}


@end
