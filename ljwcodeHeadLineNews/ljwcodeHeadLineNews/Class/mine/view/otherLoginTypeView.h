//
//  otherLoginTypeView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface otherLoginTypeView : UIView

typedef enum {
    
   LoginTypeToPassWd = 0,//密码登陆
    
   LoginTypeToTianyi = 1,//天翼登陆
    
   LoginTypeToQQ     = 2,//QQ登陆
    
   LoginTypeToWeChat = 3, //微信登陆
    
} LoginType;


@end

NS_ASSUME_NONNULL_END
