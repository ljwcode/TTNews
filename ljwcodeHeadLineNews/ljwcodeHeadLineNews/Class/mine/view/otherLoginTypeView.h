//
//  otherLoginTypeView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "loginStyleButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface otherLoginTypeView : UIView

/**
 *  打开分享Block
 */
@property (nonatomic , copy ) void (^openShareBlock)(LoginType type);

/**
 *  初始化分享视图
 *
 *  @param frame          frame
 *  @param infoArray      信息数组
 *  @param maxLineNumber  最大行数
 *  @param maxSingleCount 单行最大个数
 *
 *  @return 分享视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                    InfoArray:(NSArray *)infoArray
                MaxLineNumber:(NSInteger)maxLineNumber
               MaxSingleCount:(NSInteger)maxSingleCount;


@end

NS_ASSUME_NONNULL_END
