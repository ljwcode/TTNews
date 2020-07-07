//
//  videoPlayerItemView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol videoPlayerItemDelegate<NSObject>

-(void)videoPlayerAction:(BOOL)state;

@end

@interface videoPlayerToolView : UIView

@property(nonatomic,strong)UIButton *playPauseBtn;

@property(nonatomic,strong)UISlider *playerSlider;

@property(nonatomic,strong)UIProgressView *playerProgressView;

@property(nonatomic,strong)UILabel *playerTimeLabel;

@property(nonatomic,copy)id<videoPlayerItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
