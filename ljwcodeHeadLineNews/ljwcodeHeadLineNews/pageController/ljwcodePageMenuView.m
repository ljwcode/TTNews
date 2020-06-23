//
//  ljwcodePageMenuView.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodePageMenuView.h"
#import "UIView+frame.h"

@interface ljwcodePageMenuView()

@property(nonatomic,strong)UIView *underLineView;

@property(nonatomic,strong)NSArray *itemCount;

@property(nonatomic,strong)NSArray<NSString*> *ItemTitles;

@property(nonatomic,strong)NSMutableArray *tempItemArray;


@end

@implementation ljwcodePageMenuView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    return [self initWithFrame:frame titles:titles dataSources:nil];
}

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)title dataSources:(NSDictionary<NSString *,id> *)dataSource
{
    if(self = [super initWithFrame:frame])
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        
        self.tempItemArray = [NSMutableArray array];
        self.ItemTitles = title?:[NSArray array];
        //初始化设置item
        _hasUnderLine = [dataSource[ljwcodePageMenuViewHasUnderLine]boolValue];
        _leftMargin = dataSource[ljwcodeMenuPageLeftMargin]?[dataSource[ljwcodeMenuPageLeftMargin]floatValue]:10;
        _rightMargin = dataSource[ljwcodeMenuPageRightMargin]?[dataSource[ljwcodeMenuPageRightMargin]floatValue]:10;
        _isAutoResizing = dataSource[ljwcodeMenuPageItemIsAutoResizing]!= nil?[dataSource[ljwcodeMenuPageItemIsAutoResizing]boolValue]:YES;
        _isVerticalCenter = dataSource[ljwcodecodeMenuItemVerticalCenter] != nil ? [dataSource[ljwcodecodeMenuItemVerticalCenter]boolValue]:YES;
        _ItemPadding = dataSource[ljwcodePageMenuViewItemPadding]?[dataSource[ljwcodePageMenuViewItemPadding]floatValue]:10;
        _ItemTopPadding = dataSource[ljwcodePageMenuViewItemTopPadding]?[dataSource[ljwcodePageMenuViewItemTopPadding]floatValue]:10;
        _ItemWidth = dataSource[ljwcodePageMenuViewItemWidth]?[dataSource[ljwcodePageMenuViewItemWidth]floatValue]:20;
        _ItemHeight = dataSource[ljwcodePageMenuViewItemHeight]?[dataSource[ljwcodePageMenuViewItemHeight]floatValue]:10;
        _hasUnderLine = dataSource[ljwcodePageMenuViewHasUnderLine]!=nil?[dataSource[ljwcodePageMenuViewHasUnderLine]floatValue]:YES;
        _NormalTitleColor = dataSource[ljwcodePageMenuViewNormalTitleColor]?dataSource[ljwcodePageMenuViewNormalTitleColor]:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        _SelectedTitleColor = dataSource[ljwcodePageMenuViewSelectedTitleColor]?dataSource[ljwcodePageMenuViewSelectedTitleColor]:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51/255.0 alpha:1];
        _TitleFont = dataSource[ljwcodePageMenuViewTitleFont]?dataSource[ljwcodePageMenuViewTitleFont]:[UIFont systemFontOfSize:10.f];
        _SelectedTitleFont = dataSource[ljwcodePageMenuViewSelectedTitleFont]?dataSource[ljwcodePageMenuViewSelectedTitleFont]:[UIFont systemFontOfSize:10.f];
        _LineColor = dataSource[ljwcodePageMenuViewLineColor]?dataSource[ljwcodePageMenuViewLineColor]:[UIColor colorWithRed:12.0/255.0 green:216.0/255.0 blue:98.0/255.0 alpha:1];
        _ItemTitlePadding = dataSource[ljwcodePageMenuViewItemTitlePadding]?[dataSource[ljwcodePageMenuViewItemTitlePadding]floatValue]:10;
        _ItemTopPadding = dataSource[ljwcodePageMenuViewItemTopPadding]?[dataSource[ljwcodePageMenuViewItemTopPadding]floatValue]:4;
        _LineHeight = dataSource[ljwcodePageMenuViewLineHeight]?[dataSource[ ljwcodePageMenuViewLineHeight]floatValue]:2;
        _LineWidth = dataSource[ljwcodePageMenuViewLineWidth]?[dataSource[ljwcodePageMenuViewLineWidth]floatValue]:_ItemWidth;
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

@interface ljwcodePageItem()

@property(nonatomic,copy)void(^itemClicked)(UIButton *btn);

@end


@implementation ljwcodePageItem

//初始化item
-(instancetype)initWithFrame:(CGRect)frame widthAutoResizing:(BOOL)autoResizing title:(NSString*)title padding:(CGFloat)padding clicked:(void(^)(UIButton *button))itemClicked
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        _autoResizing = autoResizing;
        _padding = padding;
        _title = title;
        _titleFont = _selectedTitleFont = [UIFont systemFontOfSize:10.f weight:UIFontWeightRegular];
        _normalTitleColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        _selectedTitleColor = [UIColor colorWithRed:12.0/255.0 green:216.0/255.0 blue:98.0/255.0 alpha:1.0];
        _itemClicked = itemClicked;
        
        _button = ({
            UIButton *btn = [[UIButton alloc]initWithFrame:self.bounds];
            NSAttributedString *normalAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_titleFont,NSFontAttributeName,_normalTitleColor,NSForegroundColorAttributeName, nil]];
            [btn setAttributedTitle:normalAttr forState:UIControlStateNormal];
            
            NSAttributedString *selectedAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectedTitleFont,NSFontAttributeName,_selectedTitleColor,NSForegroundColorAttributeName, nil]];
            [btn setAttributedTitle:selectedAttr forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self addSubview:self.button];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(_autoResizing)//是否需要自动布局
    {
        static BOOL isNeedCalc = NO;
        if(!isNeedCalc){
            isNeedCalc = YES;
            [self.button sizeToFit];
            CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.button.width+2*_padding, self.height);
            self.frame = frame;
            self.button.frame = self.frame;
            isNeedCalc = NO;
        }
    }else{
        self.button.frame = self.frame;
    }
}

-(void)btnClicked:(UIButton *)sender
{
    if(!sender.isSelected){
        sender.selected = !sender.selected;
        if(self.itemClicked)
        {
            self.itemClicked(sender);
        }
    }
    //点击后恢复正常形态
    if(self.autoResizing)
    {
        NSAttributedString *normalAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_normalTitleColor,NSForegroundColorAttributeName,_selectedTitleFont,NSFontAttributeName, nil]];
        [self.button setAttributedTitle:normalAttr forState:UIControlStateNormal];
        [self.button sizeToFit];
        [self layoutIfNeeded];
        //重置正常形态
        NSAttributedString *reNormalAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_titleFont,NSFontAttributeName,_normalTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:reNormalAttr forState:UIControlStateNormal];
        
    }
    
}

-(void)setSelected:(BOOL)selected
{
    self.selected = selected;
    self.button.selected = _selected;
}

-(void)setPadding:(CGFloat)padding
{
    _padding = padding;
    [self layoutIfNeeded];
}

-(void)setAutoResizing:(BOOL)autoResizing
{
    _autoResizing = autoResizing;
    [self layoutIfNeeded];
}

-(void)setTitle:(NSString *)title
{
    if(_title != title)
    {
        self.title = title;
        NSAttributedString *normalAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_titleFont,NSFontAttributeName,_normalTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:normalAttr forState:UIControlStateNormal];
        
        NSAttributedString *selectedAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectedTitleFont,NSFontAttributeName,_selectedTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:selectedAttr forState:UIControlStateSelected];
        
        [self.button layoutIfNeeded];
        [self.button sizeToFit];
        
    }
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    if(_normalTitleColor != normalTitleColor)
    {
        _normalTitleColor = normalTitleColor;
        NSAttributedString *normalAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_titleFont,NSFontAttributeName,_normalTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:normalAttr forState:UIControlStateNormal];
    }
}
-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    if(_selectedTitleColor != selectedTitleColor)
    {
        _selectedTitleColor = selectedTitleColor;
        NSAttributedString *selectedAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectedTitleFont,NSFontAttributeName,_selectedTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:selectedAttr forState:UIControlStateSelected];
    }
}

-(void)setTitleFont:(UIFont *)titleFont
{
    if(_titleFont != titleFont)
    {
        _titleFont = titleFont;
        NSAttributedString *normalAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_titleFont,NSFontAttributeName,_normalTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:normalAttr forState:UIControlStateNormal];
        [self layoutIfNeeded];
        [self.button sizeToFit];
    }
}

-(void)setSelectedTitleFont:(UIFont *)selectedTitleFont
{
    if(_selectedTitleFont != selectedTitleFont)
    {
        _selectedTitleFont = selectedTitleFont;
        NSAttributedString *selectedAttr = [[NSAttributedString alloc]initWithString:_title attributes:[NSDictionary dictionaryWithObjectsAndKeys:_selectedTitleFont,NSFontAttributeName,_selectedTitleColor,NSForegroundColorAttributeName, nil]];
        [self.button setAttributedTitle:selectedAttr forState:UIControlStateSelected];
        [self layoutIfNeeded];
        [self.button sizeToFit];
    }
}



@end
