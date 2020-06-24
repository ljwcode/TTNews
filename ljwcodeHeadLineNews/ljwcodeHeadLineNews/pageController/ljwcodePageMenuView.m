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

@property(nonatomic,strong)NSArray *itemArray;

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
        _ItemWidth = dataSource[ljwcodePageMenuViewItemWidth]?[dataSource[ljwcodePageMenuViewItemWidth]floatValue]:0;
        _ItemHeight = dataSource[ljwcodePageMenuViewItemHeight]?[dataSource[ljwcodePageMenuViewItemHeight]floatValue]:30;
        _hasUnderLine = dataSource[ljwcodePageMenuViewHasUnderLine]!=nil?[dataSource[ljwcodePageMenuViewHasUnderLine]floatValue]:YES;
        _NormalTitleColor = dataSource[ljwcodePageMenuViewNormalTitleColor]?dataSource[ljwcodePageMenuViewNormalTitleColor]:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
        _SelectedTitleColor = dataSource[ljwcodePageMenuViewSelectedTitleColor]?dataSource[ljwcodePageMenuViewSelectedTitleColor]:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51/255.0 alpha:1];
        _TitleFont = dataSource[ljwcodePageMenuViewTitleFont]?dataSource[ljwcodePageMenuViewTitleFont]:[UIFont systemFontOfSize:14.f weight:UIFontWeightMedium];
        _SelectedTitleFont = dataSource[ljwcodePageMenuViewSelectedTitleFont]?dataSource[ljwcodePageMenuViewSelectedTitleFont]:[UIFont systemFontOfSize:24.f weight:UIFontWeightMedium];
        _LineColor = dataSource[ljwcodePageMenuViewLineColor]?dataSource[ljwcodePageMenuViewLineColor]:[UIColor colorWithRed:12.0/255.0 green:216.0/255.0 blue:98.0/255.0 alpha:1];
        _ItemTitlePadding = dataSource[ljwcodePageMenuViewItemTitlePadding]?[dataSource[ljwcodePageMenuViewItemTitlePadding]floatValue]:10;
        _ItemTopPadding = dataSource[ljwcodePageMenuViewItemTopPadding]?[dataSource[ljwcodePageMenuViewItemTopPadding]floatValue]:4;
        _LineHeight = dataSource[ljwcodePageMenuViewLineHeight]?[dataSource[ ljwcodePageMenuViewLineHeight]floatValue]:2;
        _LineWidth = dataSource[ljwcodePageMenuViewLineWidth]?[dataSource[ljwcodePageMenuViewLineWidth]floatValue]:_ItemWidth;
        [self setItem];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat leftMargin = self.leftMargin;
    CGFloat rightMargin = self.rightMargin;
    CGFloat itemWidth = self.ItemWidth;
    CGFloat itemHeight = self.ItemHeight;
    CGFloat itemWithMargin = self.ItemPadding;
    
    BOOL isVerticalCenter = self.isVerticalCenter;
    BOOL isAutoResizing = self.isAutoResizing;
    
    CGFloat origin_x = leftMargin;
    
    for (int i = 0 ; i < self.ItemTitles.count; i ++) {
        //
        ljwcodePageItem *beforeItem = i>0?[self.itemArray objectAtIndex:i-1]:[ljwcodePageItem new];
        if (i>0) {
            origin_x = CGRectGetMaxX(beforeItem.frame)+itemWithMargin;
        }
        ljwcodePageItem *pageItem = self.itemArray[i];
        pageItem.frame = CGRectMake(origin_x,isVerticalCenter?(self.frame.size.height-itemHeight)/2 : _ItemTopPadding, itemWidth, itemHeight);
        pageItem.autoResizing = isAutoResizing;
        pageItem.title = self.ItemTitles[i];
        pageItem.titleFont = self.TitleFont;
        pageItem.selectedTitleFont = self.SelectedTitleFont;
        pageItem.normalTitleColor = self.NormalTitleColor;
        pageItem.selectedTitleColor = self.SelectedTitleColor;
        pageItem.padding = self.ItemTitlePadding;
        //更新布局
        [self refreshUnderLineViewPosition:pageItem];
        
        if (i == self.ItemTitles.count-1) {
            self.contentSize = CGSizeMake(CGRectGetMaxX(pageItem.frame)+rightMargin, self.frame.size.height);
        }
    }
}
//刷新底部下划线的位置
-(void)refreshUnderLineViewPosition:(ljwcodePageItem *)pageItem{
    if (self.hasUnderLine) {
        if (!self.underLineView.superview) {
            [self addSubview:self.underLineView];
        }
        if (pageItem.itemSelected) {
            self.underLineView.width =  self.LineWidth;
            self.underLineView.height = _LineHeight;
            self.underLineView.layer.cornerRadius = _LineHeight/2;
            self.underLineView.top = _isVerticalCenter ? (self.height - _LineHeight) : (CGRectGetMaxY(pageItem.frame) + _LineTopPadding);
            [UIView animateWithDuration:.25 animations:^{
                self.underLineView.centerX = pageItem.centerX;
            } completion:^(BOOL finished) {
                
            }];
        }
    }else
    {
        if (self.underLineView.superview) {
            [self.underLineView removeFromSuperview];
        }
    }
}

-(void)setItem{
    
    if(self.tempItemArray.count > 0){
        [self.tempItemArray removeAllObjects];
    }
    
    CGFloat leftMargin = self.leftMargin;
    CGFloat rightMargin = self.rightMargin;
    CGFloat itemWidth = self.ItemWidth;
    CGFloat itemHeight = self.ItemHeight;
    CGFloat itemWithMargin = self.ItemPadding;
    
    BOOL isVerticalCenter = self.isVerticalCenter;
    BOOL isAutoResizing = self.isAutoResizing;
    
    CGFloat origin_x = leftMargin;
    
    for (int i = 0 ; i < self.ItemTitles.count; i ++) {
        //
        ljwcodePageItem *beforeItem = i>0?[self.itemArray objectAtIndex:i-1]:[ljwcodePageItem new];
        if (i>0) {
            origin_x = CGRectGetMaxX(beforeItem.frame)+itemWithMargin;
        }
        
        ljwcodePageItem *pageItem = [[ljwcodePageItem alloc]initWithFrame:CGRectMake(origin_x, isVerticalCenter?(self.frame.size.height-itemHeight)/2:_ItemTopPadding, itemWidth, itemHeight) widthAutoResizing:isAutoResizing title:_ItemTitles[i] padding:itemWithMargin clicked:^(UIButton * _Nonnull button) {
            
            NSInteger scrollIndex = [self.tempItemArray indexOfObject:(ljwcodePageItem *)button.superview];
            //滑动方向需要beforeIndex
            NSInteger beforIndex = self.pageScrollViewIndex;
            self.pageScrollViewIndex = scrollIndex;
            if (self.pageMenuItemClick) {
                
                self.pageMenuItemClick(scrollIndex, beforIndex, self);
                
            }else{
                if([self.pageMenuDelegate respondsToSelector:@selector(ljwcodePageMenuViewDidclickItemIndex:beforeIndex:)]){
                    [self.pageMenuDelegate ljwcodePageMenuViewDidclickItemIndex:[self.tempItemArray indexOfObject:(ljwcodePageItem *)button.superview] beforeIndex:beforIndex];
                }
            }
            
        }];
        pageItem.itemSelected = (i == 0);
        [self addSubview:pageItem];
        [self refreshUnderLineViewPosition:pageItem];
        
        if (i == self.ItemTitles.count-1) {
            self.contentSize = CGSizeMake(CGRectGetMaxX(pageItem.frame)+rightMargin, self.frame.size.height);
        }
        [self.tempItemArray addObject:pageItem];
    }
    self.itemArray = [self.tempItemArray copy];
}

- (void)scrollToPageItem:(ljwcodePageItem*)pageItem {
    
    [self refreshUnderLineViewPosition:pageItem];
    
    if (self.contentSize.width <= self.width) {
        return;
    }
    
    CGRect originalRect = pageItem.frame;
    CGFloat targetX;
    CGFloat realMidX = CGRectGetMinX(originalRect)+CGRectGetWidth(originalRect)/2;
    if (CGRectGetMidX(originalRect) < CGRectGetMidX(self.frame)) {
        //是否需要右滑
        if (realMidX > CGRectGetMidX(self.frame)) {
            targetX = realMidX-CGRectGetMidX(self.frame);
        }else
        {
            targetX = 0;
        }
        [self setContentOffset:CGPointMake(targetX, 0) animated:YES];
        
    }else if(CGRectGetMidX(originalRect) > CGRectGetMidX(self.frame))
    {
        if (realMidX+CGRectGetMidX(self.frame)<self.contentSize.width) {
            targetX = realMidX-CGRectGetMidX(self.frame);
            
        }else
        {
            targetX = self.contentSize.width - CGRectGetMaxX(self.frame);
        }
        [self setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }
    
}

- (void)updateMenuViewWithNewItemArray:(NSArray *)items selectedIndex:(NSInteger)selectedIndex
{
    if (items != nil && items.count > 0) {
        _ItemTitles = items;
        if (self.subviews.count > 0) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [self setItem];
        self.pageScrollViewIndex = selectedIndex;
       
    }
    
}

-(UIView *)underLineView
{
    if(!_underLineView)
    {
        _underLineView = [[UIView alloc]initWithFrame:CGRectZero];
        _underLineView.backgroundColor = _LineColor;
    }
    return _underLineView;
}

-(void)setPageScrollViewIndex:(NSInteger)pageScrollViewIndex
{
    _pageScrollViewIndex = pageScrollViewIndex;
    ljwcodePageItem *curPageItem = [self.itemArray objectAtIndex:pageScrollViewIndex];
    curPageItem.itemSelected = YES;
    __weak typeof(self) weakSelf = self;
    
    [self.itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           ljwcodePageItem *pageObj = (ljwcodePageItem*)obj;
           if (curPageItem != pageObj&&pageObj.itemSelected) {
               
               pageObj.itemSelected = NO;
               //根据字体大小 需要重新计算frame button sizeToFit 只依据 normal下才能正确计算 所以在选中时需要同步改变下normal下的titleFont 算出正确的大小 再进行还原
               if (weakSelf.isAutoResizing){
                   NSAttributedString *normaltitle = [[NSAttributedString alloc]initWithString:pageObj.title attributes:@{NSForegroundColorAttributeName:weakSelf.NormalTitleColor,NSFontAttributeName:weakSelf.TitleFont}];
                   [pageObj.button setAttributedTitle:normaltitle forState:UIControlStateNormal];
                   [pageObj.button sizeToFit];
                   [pageObj layoutIfNeeded];
                   
               }
           }
       }];
       [self scrollToPageItem:curPageItem];
}

#pragma mark - setter

-(void)setLeftMargin:(CGFloat)leftMargin
{
    if(_leftMargin != leftMargin)
    {
        _leftMargin = leftMargin;
        [self setNeedsLayout];
    }
}
-(void)setRightMargin:(CGFloat)rightMargin
{
    if(_rightMargin != rightMargin)
    {
        _rightMargin = rightMargin;
        [self setNeedsLayout];
    }
}

-(void)setIsAutoResizing:(BOOL)isAutoResizing
{
    if(_isAutoResizing != isAutoResizing){
        _isAutoResizing = isAutoResizing;
        [self setNeedsLayout];
    }
}

-(void)setIsVerticalCenter:(BOOL)isVerticalCenter
{
    if(_isVerticalCenter != isVerticalCenter)
    {
        _isVerticalCenter = isVerticalCenter;
        [self setNeedsLayout];
    }
}
-(void)setItemPadding:(CGFloat)ItemPadding
{
    if(_ItemPadding != ItemPadding)
    {
        _ItemPadding = ItemPadding;
        [self setNeedsLayout];
    }
}

-(void)setItemTopPadding:(CGFloat)ItemTopPadding
{
    if(_ItemTopPadding != ItemTopPadding){
        _ItemTopPadding = ItemTopPadding;
        [self setNeedsLayout];
    }
}

-(void)setItemHeight:(CGFloat)ItemHeight
{
    //需要垂直居中：itemHeight+2*underLineView.height*2
    //不需要垂直居中 itemHeight+itemTopPadding+underLineView.height+linTopPadding
    _ItemHeight = ItemHeight;
    CGFloat totalHeight = self.isVerticalCenter ? _ItemHeight + self.underLineView.height*2 : _ItemHeight +_ItemTopPadding+self.underLineView.height+self.LineTopPadding;
    if (totalHeight > self.height) {
        if (self.isVerticalCenter) {
            self.height = _ItemHeight + self.underLineView.height*2;
        }else{
            self.height = _ItemHeight +_ItemTopPadding+self.underLineView.height+self.LineTopPadding;
        }
    }
    [self setNeedsLayout];
}

-(void)setItemWidth:(CGFloat)ItemWidth
{
    if(_ItemWidth != ItemWidth){
        _ItemWidth = ItemWidth;
        [self setNeedsLayout];
    }
}

-(void)setHasUnderLine:(BOOL)hasUnderLine
{
    if(_hasUnderLine != hasUnderLine)
    {
        _hasUnderLine = hasUnderLine;
        [self setNeedsLayout];
    }
}

-(void)setNormalTitleColor:(UIColor *)NormalTitleColor
{
    if(_NormalTitleColor != NormalTitleColor)
    {
        _NormalTitleColor = NormalTitleColor;
        [self setNeedsLayout];
    }
}

-(void)setSelectedTitleColor:(UIColor *)SelectedTitleColor{
    if(_SelectedTitleColor != SelectedTitleColor)
    {
        _SelectedTitleColor = SelectedTitleColor;
        [self setNeedsLayout];
    }
}

-(void)setTitleFont:(UIFont *)TitleFont
{
    if(_TitleFont != TitleFont){
        _TitleFont = TitleFont;
        [self setNeedsLayout];
    }
}

-(void)setSelectedTitleFont:(UIFont *)SelectedTitleFont
{
    if(_SelectedTitleFont != SelectedTitleFont){
        _SelectedTitleFont = SelectedTitleFont;
        [self setNeedsLayout];
    }
}

-(void)setLineColor:(UIColor *)LineColor{
    if(_LineColor != LineColor){
        _LineColor = LineColor;
        _underLineView.backgroundColor = _LineColor;
    }
}

-(void)setItemTitlePadding:(CGFloat)ItemTitlePadding{
    if(_ItemTitlePadding != ItemTitlePadding){
        _ItemTitlePadding = ItemTitlePadding;
        [self setNeedsLayout];
    }
}

-(void)setLineTopPadding:(CGFloat)LineTopPadding
{
    /*
     
     */
    _LineTopPadding = LineTopPadding;
    CGFloat totalHeight = self.isVerticalCenter?_ItemHeight + self.underLineView.height*2:_ItemHeight +_ItemTopPadding+self.underLineView.height+self.LineTopPadding;
    if (totalHeight > self.height) {
        if (self.isVerticalCenter) {
            self.height = _ItemHeight + self.underLineView.height*2;
        }else{
            self.height = _ItemHeight +_ItemTopPadding+self.underLineView.height+self.LineTopPadding;
        }
    }
    [self setNeedsLayout];
}

-(void)setLineHeight:(CGFloat)LineHeight{
    _LineHeight = LineHeight;
    //更新self的高度
    self.underLineView.height = _LineHeight;
    CGFloat totalHeight = self.isVerticalCenter?_ItemHeight + self.underLineView.height*2:_ItemHeight +_ItemTopPadding+self.underLineView.height+self.LineTopPadding;
    if (totalHeight > self.height) {
        if (self.isVerticalCenter) {
            self.height = _ItemHeight + self.underLineView.height*2;
        }else{
            self.height = _ItemHeight +_ItemTopPadding+self.underLineView.height+self.LineTopPadding;
        }
    }
    [self setNeedsLayout];
}

-(void)setLineWidth:(CGFloat)LineWidth
{
    if(_LineWidth != LineWidth){
        _LineWidth = LineWidth;
        [self setNeedsLayout];
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
        sender.selected = !sender.isSelected;
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

-(void)setitemSelected:(BOOL)itemSelected
{
    self.itemSelected = itemSelected;
    self.button.selected = _itemSelected;
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
