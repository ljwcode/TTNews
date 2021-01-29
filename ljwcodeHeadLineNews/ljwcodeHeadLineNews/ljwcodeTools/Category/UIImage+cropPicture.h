//
//  UIImage+cropPicture.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (cropPicture)

- (UIImage *)cropPictureWithRoundedCorner:(CGFloat)radius size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
