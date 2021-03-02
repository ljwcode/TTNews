//
//  TTArticleSearchTagCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTArticleSearchTagCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *leftSearchTagItemView;

@property (weak, nonatomic) IBOutlet UILabel *leftSearchTagItemLabel;

@property (weak, nonatomic) IBOutlet UIView *rightSearchTagItemView;

@property (weak, nonatomic) IBOutlet UILabel *rightSearchTagItemLabel;

@end

NS_ASSUME_NONNULL_END
