//
//  TTVideoDetailView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/1.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_VideoDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TT_VideoDetailViewDelegate <NSObject>

-(void)TT_VideoDetailCommentView;

@end

@interface TTVideoDetailView : UIView

@property(nonatomic,strong)TT_VideoDetailModel *detailModel;

@property(nonatomic,weak)id<TT_VideoDetailViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
