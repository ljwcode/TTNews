//
//  homeNewsTableViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/23.
//  Copyright © 2020 melody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeNewsModel.h"
#import "TT_ClickHightLightTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol homeNewsTableViewCellDelegate<NSObject>

@end

@interface homeNewsTableViewCell : TT_ClickHightLightTableViewCell

@property(nonatomic,weak)id<homeNewsTableViewCellDelegate> delegate;

@property(nonatomic,strong)homeNewsSummaryModel *summaryModel;

@end

NS_ASSUME_NONNULL_END
