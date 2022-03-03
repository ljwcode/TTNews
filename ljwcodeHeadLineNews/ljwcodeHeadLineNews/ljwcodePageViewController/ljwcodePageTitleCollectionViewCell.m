//
//  ljwcodePageTitleCollectionViewCell.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/15.
//

#import "ljwcodePageTitleCollectionViewCell.h"

@interface ljwcodePageTitleLabel : UILabel

@property(nonatomic,assign)ljwcodePageTextVerticalAlignment textVerticalAlignment;

@end


@implementation ljwcodePageTitleLabel

-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.textVerticalAlignment) {
        case ljwcodePageTextVerticalAlignmentCenter:
            textRect.origin.y = (bounds.size.height - textRect.size.height)/2.0;
            break;
        case ljwcodePageTextVerticalAlignmentTop: {
            CGFloat topY = self.font.pointSize > [UIFont labelFontSize] ? 0 : 2;
            textRect.origin.y = topY;
        }
            break;
        case ljwcodePageTextVerticalAlignmentBottom:
            textRect.origin.y = bounds.size.height - textRect.size.height;
            break;
        default:
            break;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end

@interface ljwcodePageTitleCollectionViewCell()


@end

@implementation ljwcodePageTitleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        self.textLabel = [[ljwcodePageTitleLabel alloc]init];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.textLabel];
        self.config = [ljwcodePageViewControllerConfig defaultConfig];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

-(void)configCellOfSelected:(BOOL)selected {
    self.textLabel.textColor = selected ? self.config.titleSelectedColor : self.config.titleNormalColor;
    self.textLabel.font = selected ? self.config.titleSelectedFont : self.config.titleNormalFont;
    ljwcodePageTitleLabel *titleLabel = (ljwcodePageTitleLabel *)self.textLabel;
    titleLabel.textVerticalAlignment = self.config.textVerticalAlignment;
}

-(void)showAnimationOfProgress:(CGFloat)progress cellAnimationType:(ljwcodePageTitleCellAnimationType)type{
    if(type == ljwcodePageTitleCellAnimationTypeSelected) {
        self.textLabel.textColor = [ljwcodePageViewControllerUtil colorTransform:self.config.titleSelectedColor toColor:self.config.titleNormalColor progress:progress];
    }else {
        self.textLabel.textColor = [ljwcodePageViewControllerUtil colorTransform:self.config.titleNormalColor toColor:self.config.titleSelectedColor progress:progress];
    }
}

@end
