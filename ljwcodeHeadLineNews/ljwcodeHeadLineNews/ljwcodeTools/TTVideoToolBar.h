//
//  TTVideoToolBar.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTScreen.h"
#import "videoContentModel.h"

NS_ASSUME_NONNULL_BEGIN

#define TTToolBarHeight UI(60)

@interface TTVideoToolBar : UIView

@property(nonatomic,strong)videoContentModel *contentModel;

- (void)layoutWithModel:(nullable id)model;

@end

NS_ASSUME_NONNULL_END
