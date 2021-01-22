//
//  UILabel+Frame.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Frame)

/**宽度不变，自动拉伸高度*/

- (void)TTContentFitHeight;

/**高度不变，适应自字体的宽度*/

- (void)TTContentFitWidth;

@end

NS_ASSUME_NONNULL_END
