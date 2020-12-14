//
//  TTPlayerView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,VideoFillMode){
    Resize = 0,          //拉伸占满整个播放器，不按原比例拉伸
    ResizeAspect,        //按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
    ResizeAspectFill,    //按照原比例拉伸占满整个播放器，但视频内容超出部分会被剪切
};

typedef void(^BackButtonBlock)(UIButton *button);
typedef void(^EndBolck)(void);
typedef void(^BeyondBlock)(void);

@interface TTPlayerView : UIView

/**视频url*/
@property (nonatomic,strong) NSURL *url;
/**旋转自动全屏，默认Yes*/
@property (nonatomic,assign) BOOL autoFullScreen;
/**重复播放，默认No*/
@property (nonatomic,assign) BOOL repeatPlay;
/**是否支持横屏，默认No*/
@property (nonatomic,assign) BOOL isLandscape;
/**拉伸方式，默认全屏填充*/
@property (nonatomic,assign) VideoFillMode fillMode;



/**播放*/
- (void)playVideo;
/**暂停*/
- (void)pausePlay;
/**返回按钮回调方法*/
- (void)backButton:(BackButtonBlock) backButton;
/**播放完成回调*/
- (void)endPlay:(EndBolck) end;
/**销毁播放器*/
- (void)destroyPlayer;


/**
 根据播放器所在位置计算偏移，添加在TableView上使用
 
 @param tableView tableView
 @param cell 播放器所在cell
 */
- (void)calculateScrollOffset:(UITableView *)tableView cell:(UITableViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
