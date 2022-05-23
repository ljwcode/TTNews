//
//  otherLoginTypeView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol RespToWXDelegate <NSObject>

-(void)RespToWX;

@end

@interface otherLoginTypeView : UIView

@property(nonatomic,assign)id<RespToWXDelegate,NSObject>delegate;

@end

NS_ASSUME_NONNULL_END
