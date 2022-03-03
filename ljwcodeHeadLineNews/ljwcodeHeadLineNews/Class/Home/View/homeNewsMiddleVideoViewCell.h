//
//  homeNewsMiddleVideoViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeNewsMiddleCoverViewModel.h"
#import "TT_ClickHightLightTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol homeNewsMiddleVideoViewCellDelegate <NSObject>

-(void)playVideoHandle;

-(void)deleteNewsCellHandle;

@end

@interface homeNewsMiddleVideoViewCell : TT_ClickHightLightTableViewCell

@property(nonatomic,weak)id<homeNewsMiddleVideoViewCellDelegate> delegate;

@property(nonatomic,strong)homeNewsSummaryModel *summaryModel;

@end

NS_ASSUME_NONNULL_END
