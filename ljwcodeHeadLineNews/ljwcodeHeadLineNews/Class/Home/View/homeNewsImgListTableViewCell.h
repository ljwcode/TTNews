//
//  homeNewsImgListTableViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeNewsModel.h"
#import "TT_ClickHightLightTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol homeNewsImgListTableViewCellDelegate <NSObject>

-(void)deleteNewsCellHandle;

@end

@interface homeNewsImgListTableViewCell : TT_ClickHightLightTableViewCell

@property(nonatomic,weak)id<homeNewsImgListTableViewCellDelegate> delegate;

@property(nonatomic,strong)homeNewsSummaryModel *newsSummaryModel;

@end

NS_ASSUME_NONNULL_END
