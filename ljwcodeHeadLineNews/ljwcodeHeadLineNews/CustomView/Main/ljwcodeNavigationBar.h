//
//  ljwcodeNavigationBar.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/22.
//  Copyright © 2020 ljwcode. All rights reserved.
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

@interface ljwcodeSearchBar : UISearchBar

@end

@interface ljwcodeImageAction : UIButton

@property(nonatomic,copy)void(^ljwcodeImageActionClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
