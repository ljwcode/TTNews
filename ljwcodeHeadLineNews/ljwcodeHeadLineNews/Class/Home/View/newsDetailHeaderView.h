//
//  newsDetailHeaderView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface newsDetailHeaderView : UIView

@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,copy)NSString *authorHeadImgUrl;

@property(nonatomic,copy)NSString *authorName;

@property(nonatomic,copy)NSString *articleTitle;

@property(nonatomic,copy)NSString *authorAbstract;

-(void)setHeadViewDataSource;

@end

NS_ASSUME_NONNULL_END
