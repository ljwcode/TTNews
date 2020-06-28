//
//  ljwcodeNavigationBar.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/22.
//  Copyright © 2020 melody. All rights reserved.
//

#import "ljwcodeNavigationBar.h"
#import "ljwcodeHeader.h"

@interface ljwcodeSearchBar : UITextField

@end

@interface ljwcodeImageAction : UIImageView

@property(nonatomic,copy)void(^ljwcodeImageActionClickBlock)(void);

@end

@interface ljwcodeNavigationBar()<UITextFieldDelegate>


@end

@implementation ljwcodeNavigationBar

+(instancetype)ljwcodeNavigationBar
{
    ljwcodeNavigationBar *navBar = [[ljwcodeNavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height == 812?88:64)];
    navBar.backgroundColor = [UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1];
    return navBar;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        ljwcodeImageAction *loginHeadImgView = [[ljwcodeImageAction alloc]init];
        loginHeadImgView.image = [UIImage imageNamed:@"home_no_login_head"];
        [self addSubview:loginHeadImgView];
        @weakify(self);
        [loginHeadImgView setLjwcodeImageActionClickBlock:^{
            @strongify(self);
            if(self.ljwcodeActionCallBack)
            {
                self.ljwcodeActionCallBack(ljwcodeNavigationBarActonMind);
            }
        }];
                
        ljwcodeSearchBar *searchBar = [[ljwcodeSearchBar alloc]init];
        UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"searchicon_search_20x20_"];
        searchBar.leftView = leftView;
        searchBar.text = @"搜一搜";
        searchBar.delegate = self;
        searchBar.backgroundColor = [UIColor lightGrayColor];
        searchBar.textColor = [UIColor blackColor];
        searchBar.leftViewMode = UITextFieldViewModeAlways;
        searchBar.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:searchBar];
        
        ljwcodeImageAction *cameraImgView = [[ljwcodeImageAction alloc]init];
        cameraImgView.image = [UIImage imageNamed:@"home_camera"];
        [self addSubview:cameraImgView];
        
        [cameraImgView setLjwcodeImageActionClickBlock:^{
            @strongify(self);
            if(self.ljwcodeActionCallBack)
            {
                self.ljwcodeActionCallBack(ljwcodeNavigationBarActionSend);
            }
        }];
        [loginHeadImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self).offset(-9);
            make.left.mas_equalTo(self).offset(15);
        }];

        [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(26);
            make.left.mas_equalTo(loginHeadImgView.mas_right).offset(15);
            make.bottom.mas_equalTo(self).offset(-9);
            make.right.mas_equalTo(cameraImgView.mas_left).offset(-15);
        }];

        [cameraImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self).offset(-9);
            make.right.mas_equalTo(self).offset(-15);
        }];
        
        _navigationBarActionSubject = [RACSubject subject];
        
    }
    return self;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [_navigationBarActionSubject sendNext:textField];
    return NO;
}

-(CGSize)intrinsicContentSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width-24, 44);
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@implementation ljwcodeSearchBar

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 8;
    return iconRect;
}
@end

@implementation ljwcodeImageAction

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = NO;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.ljwcodeImageActionClickBlock)
    {
        self.ljwcodeImageActionClickBlock();
    }
}

@end
