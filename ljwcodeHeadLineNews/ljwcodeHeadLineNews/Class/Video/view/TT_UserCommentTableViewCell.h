//
//  TT_UserCommentTableViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_VideoCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TT_UserCommentTableViewCell : UITableViewCell

@property(nonatomic,strong)TT_VideoCommentModel *commentModel;

@end

NS_ASSUME_NONNULL_END
