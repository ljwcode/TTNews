//
//  discussEditView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/6.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "discussEditView.h"

@interface discussEditView()<UITextViewDelegate>

@property(nonatomic,weak)UITextView *wirteDiscussTextView;

@property(nonatomic,weak)UIButton *reportBtn;

@property(nonatomic,weak)UIButton *checkBoxBtn;

@property(nonatomic,weak)UILabel *transmitLabel;

@property(nonatomic,weak)UIButton *selectedImgBtn;

@property(nonatomic,weak)UIButton *wellBtn;

@property(nonatomic,weak)UIButton *notifyBtn;

@property(nonatomic,weak)UIButton *selectedGifBtn;

@property(nonatomic,weak)UIButton *selectedEmojiBtn;

@property(nonatomic,weak)UILabel *placeHolderLabel;

@property(nonatomic,assign)BOOL isSelected;

@end

static int LimitMaxWord = 100;
@implementation discussEditView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.wirteDiscussTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(vSpace);
            make.height.mas_equalTo(60);
        }];
        
        [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wirteDiscussTextView.mas_right).offset(0);
            make.top.mas_equalTo(self.wirteDiscussTextView);
            make.right.mas_equalTo(hSpace);
        }];
        
        [self.checkBoxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(hSpace);
            make.top.mas_equalTo(self.wirteDiscussTextView.mas_bottom).offset(vSpace);
            make.bottom.mas_equalTo(vSpace);
            make.height.width.mas_equalTo(20);
        }];
        [self.transmitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.checkBoxBtn.mas_right).offset(hSpace);
            make.top.mas_equalTo(self.checkBoxBtn);
            make.bottom.mas_equalTo(self.checkBoxBtn);
            make.height.mas_equalTo(self.checkBoxBtn);
        }];
        
        [self.selectedImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_lessThanOrEqualTo(2 * self.transmitLabel.width);
            make.width.mas_equalTo(1.5 * self.checkBoxBtn.width);
            make.height.mas_equalTo(self.checkBoxBtn.height);
            make.top.mas_equalTo(self.transmitLabel);
            make.bottom.mas_equalTo(self.transmitLabel);
        }];
        
        CGFloat margin = (self.selectedImgBtn.x - 5 * self.selectedImgBtn.width - hSpace) / 4;
        [self.notifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectedImgBtn.mas_right).offset(margin);
            make.top.mas_equalTo(self.selectedImgBtn);
            make.width.height.mas_equalTo(self.selectedImgBtn);
            make.bottom.mas_equalTo(self.selectedImgBtn);
        }];
        
        [self.wellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.notifyBtn.mas_right).offset(margin);
            make.top.mas_equalTo(self.notifyBtn);
            make.bottom.mas_equalTo(self.notifyBtn);
            make.width.height.mas_equalTo(self.notifyBtn);
        }];
        
        [self.selectedGifBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wellBtn.mas_right).offset(margin);
            make.top.mas_equalTo(self.wellBtn);
            make.bottom.mas_equalTo(self.wellBtn);
            make.width.height.mas_equalTo(self.wellBtn);
        }];
        
        [self.selectedEmojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.selectedGifBtn.mas_right).offset(margin);
            make.right.mas_equalTo(hSpace);
            make.top.mas_equalTo(self.selectedGifBtn);
            make.bottom.mas_equalTo(self.selectedGifBtn);
            make.width.height.mas_equalTo(self.selectedGifBtn);
        }];
        /*
         1 2 3 4 5
         */
    }
    /*
     1
     
     1
     */
    return self;
}

#pragma mark - lazy load

-(UITextView *)wirteDiscussTextView{
    if(!_wirteDiscussTextView){
        UITextView *textView = [[UITextView alloc]init];
        textView.delegate = self;
        [textView setValue:self.placeHolderLabel forKey:@"_placeHolderLabel"];
        textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        [self addSubview:textView];
        _wirteDiscussTextView = textView;
    }
    return _wirteDiscussTextView;
}

-(UIButton *)reportBtn{
    if(!_reportBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];;
        [btn setTitle:@"发布" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:btn];
        _reportBtn = btn;
    }
    return _reportBtn;
}

-(UILabel *)placeHolderLabel{
    if(!_placeHolderLabel){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"优质评论将会被优先展示";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [label sizeToFit];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

-(UIButton *)checkBoxBtn{
    if(!_checkBoxBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"oauth_unchecked"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkBoxHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _checkBoxBtn = btn;
        _isSelected = NO;
    }
    return _checkBoxBtn;
}

-(UILabel *)transmitLabel{
    if(!_transmitLabel){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"同时转发";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:13.f];
        [label sizeToFit];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _transmitLabel = label;
    }
    return _transmitLabel;
}

-(UIButton *)selectedImgBtn{
    if(!_selectedImgBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"image_upload"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedImgHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _selectedImgBtn = btn;
    }
    return _selectedImgBtn;
}

-(UIButton *)notifyBtn{
    if(!_notifyBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(notifyHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _notifyBtn = btn;
    }
    return _notifyBtn;
}

-(UIButton *)wellBtn{
    if(!_wellBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(wellHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _wellBtn = btn;
    }
    return _wellBtn;
}

-(UIButton *)selectedGifBtn{
    if(!_selectedGifBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"comment_gif_image"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedGifHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _selectedGifBtn = btn;
    }
    return _selectedGifBtn;
}

-(UIButton *)selectedEmojiBtn{
    if(!_selectedEmojiBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedEmojiHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _selectedEmojiBtn = btn;
    
    }
    return _selectedEmojiBtn;
}

#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *str = [NSString stringWithFormat:@"%@%@",textView.text,text];
    if (str.length > LimitMaxWord)
     {
        NSRange rangeIndex = [str rangeOfComposedCharacterSequenceAtIndex:100];
        if (rangeIndex.length == 1)
        {
            textView.text = [str substringToIndex:100];
        }else{
            NSRange rangeRange = [str rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 100)];
            textView.text = [str substringWithRange:rangeRange];
        }
         return NO;
     }
     return YES;
}


#pragma mark - 点击事件响应
-(void)checkBoxHandle:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(sender){
        _isSelected = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"details_choose_ok_icon"] forState:UIControlStateNormal];
    }else{
        _isSelected = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"oauth_unchecked"] forState:UIControlStateNormal];
    }
}

-(void)selectedImgHandle:(UIButton *)sender{
    
}

-(void)notifyHandle:(UIButton *)sender{
    
}

-(void)wellHandle:(UIButton *)sender{
    
}

-(void)selectedGifHandle:(UIButton *)sender{
    
}

-(void)selectedEmojiHandle:(UIButton *)sender{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
