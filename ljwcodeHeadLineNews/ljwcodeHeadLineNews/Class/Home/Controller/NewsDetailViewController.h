//
//  NewsDetailViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailViewController : UIViewController

/*
1:点击某一行，拿到点击跳转时的请求数据模型
新闻链接url，头像url，作者名称，新闻标题，作者简介
*/

@property(nonatomic,copy)NSString *urlString;

@end

NS_ASSUME_NONNULL_END
