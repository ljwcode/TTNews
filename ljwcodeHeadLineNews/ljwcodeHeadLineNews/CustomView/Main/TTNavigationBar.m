//
//  TTNavigationBar.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/22.
//  Copyright © 2020 melody. All rights reserved.
//

#import "TTNavigationBar.h"
#import "TTHeader.h"
#import <objc/runtime.h>

@interface TTNavigationBar()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *leftView;

@end

@implementation TTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textFieldLeftView:(UIImageView *)leftView showCancelButton:(BOOL)showCancelButton tintColor:(UIColor *)tintColor {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 16.f;
        self.frame = frame;
        self.tintColor = tintColor; //光标颜色
        self.barTintColor = [UIColor whiteColor];
        if (@available(iOS 13.0, *)) {
            self.searchTextField.backgroundColor = [UIColor whiteColor];
        } else {
            // Fallback on earlier versions
        }
        if (@available(iOS 13.0, *)) {
            self.searchTextField.layer.cornerRadius = 16.f;
        } else {
            // Fallback on earlier versions
        }
        self.placeholder = placeholder;
        self.showsCancelButton = showCancelButton;
        self.leftView = leftView; // 用来代替左边的放大镜.
        [self setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal]; // 替换输入过程中右侧的clearIcon
        
        if (systemVersion >= 11.0) {
            [[self.heightAnchor constraintEqualToConstant:44.0] setActive:YES];
        } else {
            [self setLeftPlaceholder];
        }
    }
    return self;
}

- (void)setLeftPlaceholder {
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"setCenter", @"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centeredPlaceholder = NO;
        NSMethodSignature *signature = [[UISearchBar class] instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centeredPlaceholder atIndex:2];
        [invocation invoke];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    // search field
    UITextField *searchField = [self valueForKey:@"searchField"];
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.textColor = [UIColor whiteColor];
    searchField.font = [UIFont systemFontOfSize:16];
    searchField.layer.cornerRadius = 12.f;
    searchField.clipsToBounds = YES;
    searchField.leftView = self.leftView;

    if (@available(iOS 11.0, *)) {
        // 查看视图层级，在iOS 11之前searchbar的x是12
        searchField.frame = CGRectMake(12, 8, kScreenWidth*0.8, 28);

    } else {
        searchField.frame = CGRectMake(0, 8, kScreenWidth*0.8, 28);
    }

    searchField.borderStyle = UITextBorderStyleNone;
    searchField.layer.cornerRadius = 12;

    searchField.layer.masksToBounds = YES;
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
//    [self setValue:searchField forKey:@"searchField"];
    
    self.searchTextPositionAdjustment = (UIOffset){10, 0}; // 光标偏移量
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
