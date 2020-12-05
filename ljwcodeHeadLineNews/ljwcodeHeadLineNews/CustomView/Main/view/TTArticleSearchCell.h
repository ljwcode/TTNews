//
//  TTArticleSearchCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTArticleSearchCell : UITableViewCell

@property(nonatomic,strong)UIView *leftSearchHistoryTagView;

@property(nonatomic,strong)UILabel *leftTagLabel;

@property(nonatomic,strong)UIButton *leftDelTagBtn;

@property(nonatomic,strong)UIView *rightSearchHistoryTagView;

@property(nonatomic,strong)UILabel *rightTagLabel;

@property(nonatomic,strong)UIButton *rightDelTagBtn;

@end

NS_ASSUME_NONNULL_END
