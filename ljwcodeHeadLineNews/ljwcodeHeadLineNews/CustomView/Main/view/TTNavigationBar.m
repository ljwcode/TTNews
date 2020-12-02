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

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textFieldLeftView:(UIImageView *)leftView tintColor:(UIColor *)tintColor {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.tintColor = tintColor; //光标颜色
        self.barTintColor = [UIColor whiteColor];
        self.placeholder = placeholder;
        self.barStyle = UIBarStyleDefault;
        self.leftView = leftView; // 用来代替左边的放大镜.
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

    UITextField *searchField = [self valueForKey:@"searchField"];
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.textColor = [UIColor whiteColor];
    searchField.font = [UIFont systemFontOfSize:16.f];
    searchField.clipsToBounds = YES;
    searchField.leftView = self.leftView;
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.layer.cornerRadius = 16.f;
    searchField.layer.masksToBounds = YES;
    [searchField setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.textColor"];
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
