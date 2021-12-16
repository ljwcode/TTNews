//
//  TTArticleSearchHeaderCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TTArticleSearchHeaderDelegate <NSObject>

@optional

-(void)showMoreSearchHistory;

@end

@interface TTArticleSearchHeaderCell : UITableViewCell

@property(nonatomic,copy)id<TTArticleSearchHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
