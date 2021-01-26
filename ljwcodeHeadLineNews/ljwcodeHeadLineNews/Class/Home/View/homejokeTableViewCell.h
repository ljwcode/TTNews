//
//  homejokeTableViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeJokeModel.h"
#import "TT_ClickHightLightTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface homejokeTableViewCell : TT_ClickHightLightTableViewCell

@property(nonatomic,strong)homeJokeSummarymodel *jokeSummaryModel;

@end

NS_ASSUME_NONNULL_END
