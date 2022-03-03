//
//  ljwcodePageTitleCollectionViewCell.h
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/15.
//

#import <UIKit/UIKit.h>
#import "ljwcodePageViewControllerUtil.h"
#import "ljwcodePageViewControllerConfig.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ljwcodePageTitleCellAnimationType) {
    ljwcodePageTitleCellAnimationTypeSelected = 0,
    ljwcodePageTitleCellAnimationTypeWillSelect = 1
};

@interface ljwcodePageTitleCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)ljwcodePageViewControllerConfig *config;

@property(nonatomic,strong)UILabel *textLabel;

-(void)configCellOfSelected:(BOOL)selected;

-(void)showAnimationOfProgress:(CGFloat)progress cellAnimationType:(ljwcodePageTitleCellAnimationType)type;

@end

NS_ASSUME_NONNULL_END
