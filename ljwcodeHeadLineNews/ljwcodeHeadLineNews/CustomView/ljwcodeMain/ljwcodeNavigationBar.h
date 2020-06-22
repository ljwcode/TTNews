//
//  ljwcodeNavigationBar.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/22.
//  Copyright © 2020 melody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger
{
    ljwcodeNavigationBarActionSend = 0,
    ljwcodeNavigationBarActonMind  = 1,
}ljwcodeNavigationBarAction;

@interface ljwcodeNavigationBar : UIView

@property(nonatomic,strong)RACSubject *navigationBarActionSubject;

@property(nonatomic,copy)void(^ljwcodeActionCallBack)(ljwcodeNavigationBarAction action);

+(instancetype)ljwcodeNavigationBar;

@end

NS_ASSUME_NONNULL_END
