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
        self.searchTextField.layer.cornerRadius = 16.f;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
