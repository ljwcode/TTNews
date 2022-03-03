//
//  TTReportArticleView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TTReportArticleViewDelegate<NSObject>

-(void)TT_deallocReportArticleView;

@end

@interface TTReportArticleView : UIView

@property(nonatomic,weak)id<TTReportArticleViewDelegate>delegate;

@end

@interface UITableViewCell (TTTableViewCellLineShow)

@end

NS_ASSUME_NONNULL_END
