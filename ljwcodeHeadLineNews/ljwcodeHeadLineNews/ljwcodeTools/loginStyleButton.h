//
//  loginStyleButton.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface loginStyleButton : UIButton

typedef enum {
    
   LoginTypeToPassWd = 0,//密码登陆
    
   LoginTypeToTianyi = 1,//天翼登陆
    
   LoginTypeToQQ     = 2,//QQ登陆
    
   LoginTypeToWeChat = 3, //微信登陆
    
} LoginType;

/**
 *  设置标题图标
 *
 *  @param title 标题
 *  @param image 图标
 */
- (void)configTitle:(NSString *)title Image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
