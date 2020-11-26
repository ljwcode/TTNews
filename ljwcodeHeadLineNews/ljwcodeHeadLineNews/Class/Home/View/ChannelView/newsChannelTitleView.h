//
//  newsChannelTitleView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface newsChannelTitleView : UIView

@property(nonatomic,copy)void(^callBack)(BOOL selected);

@property (weak, nonatomic) IBOutlet UIButton *editButton;

-(instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle needEdit:(BOOL)needEdit;


@end

NS_ASSUME_NONNULL_END
