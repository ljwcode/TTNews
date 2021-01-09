//
//  TT_AutoLayoutLabel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/8.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TT_AutoLayoutLabel : UILabel

-(instancetype)initWithFrame:(CGRect)frame withContent:(NSString *)text withTextColor:(UIColor *)color WithSuperView:(UIView *)superView;
@end

NS_ASSUME_NONNULL_END
