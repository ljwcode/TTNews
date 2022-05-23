//
//  countryCodeView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface countryCodeView : UIView

@property(nonatomic,copy)void(^didSelectCallback)(NSString *text);

@end

NS_ASSUME_NONNULL_END
