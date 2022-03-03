//
//  ljwcodePageBasicTitleView.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/15.
//

#import "ljwcodePageBasicTitleView.h"

@interface ljwcodePageTitleCellModel : NSObject

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,assign)CGRect frame;

@end

@implementation ljwcodePageTitleCellModel


@end

@interface ljwcodePageTitleViewFollowLayout : UICollectionViewFlowLayout

@property(nonatomic,assign)ljwcodePageTitleViewAlignment alignment;

@property(nonatomic,assign)UIEdgeInsets originSectionInset;

@property(nonatomic,assign)BOOL haveUpdateInset;

@end

@implementation ljwcodePageTitleViewFollowLayout

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    if(self.haveUpdateInset){
        return [super layoutAttributesForElementsInRect:rect];
    }
    CGRect targetRect = rect;
    targetRect.size = self.collectionView.bounds.size;
    NSArray *attributes = [super layoutAttributesForElementsInRect:targetRect];
    
    CGFloat totalItemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    if(attributes.count < totalItemCount){
        return [super layoutAttributesForElementsInRect:rect];
    }
    self.haveUpdateInset = true;
    UICollectionViewLayoutAttributes *firstAttribute = attributes.firstObject;
    UICollectionViewLayoutAttributes *lastAttribute = attributes.lastObject;
    CGFloat attributesFullWidth = CGRectGetMaxX(lastAttribute.frame) - CGRectGetMinX(firstAttribute.frame);
    CGFloat emptyWidth = self.collectionView.bounds.size.width - attributesFullWidth;
    CGFloat insetLeft = 0;
    if(self.alignment == ljwcodePageTitleViewAlignmentLeft) {
        insetLeft = self.originSectionInset.left;
    }
    if(self.alignment == ljwcodePageTitleViewAlignmentCenter){
        insetLeft = emptyWidth/2.f;
    }
    if(self.alignment == ljwcodePageTitleViewAlignmentRight){
        insetLeft = emptyWidth - self.originSectionInset.right;
    }
    insetLeft = insetLeft - self.originSectionInset.left ? self.originSectionInset.left : insetLeft;
    if(insetLeft == self.sectionInset.left){
        return [super layoutAttributesForElementsInRect:rect];
    }
    
    self.sectionInset = UIEdgeInsetsMake(self.sectionInset.top, insetLeft, self.sectionInset.bottom, self.sectionInset.right);
    return [super layoutAttributesForElementsInRect:rect];
}

@end

@interface ljwcodePageBasicTitleView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)ljwcodePageTitleViewFollowLayout *layout;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)ljwcodePageViewControllerConfig *config;

@property(nonatomic,strong)UIView *shadowLine;

@property(nonatomic,strong)UIView *separatorLine;

@property(nonatomic,strong)NSMutableArray *cellModelArray;

@end

@implementation ljwcodePageBasicTitleView

-(instancetype)initWithConfig:(ljwcodePageViewControllerConfig *)config{
    if(self = [super init]){
        [self initTitleViewWithConfig:config];
    }
    return self;
}

-(void)initTitleViewWithConfig:(ljwcodePageViewControllerConfig *)config{
    self.cellModelArray = [[NSMutableArray alloc]init];
    
    self.config = config;
    self.layout = [[ljwcodePageTitleViewFollowLayout alloc]init];
    self.layout.alignment = self.config.titleViewAlignment;
    self.layout.originSectionInset = self.config.titleViewInsets;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.sectionInset = config.titleViewInsets;
    self.layout.minimumInteritemSpacing = config.titleSpace;
    self.layout.minimumLineSpacing = config.titleSpace;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = config.titleViewBackgroundColor;
    [self.collectionView registerClass:[ljwcodePageTitleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ljwcodePageTitleCollectionViewCell class])];
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:self.collectionView];
    
    self.separatorLine = [[UIView alloc]init];
    self.separatorLine.backgroundColor = config.separatorLineColor;
    self.separatorLine.hidden = config.showSeparatorLine;
    [self addSubview:self.separatorLine];
    
    self.shadowLine = [[UIView alloc]init];
    [self.shadowLine setFrame:CGRectMake(10, 0, self.config.shadowLineWidth, self.config.shadowLineHeight)];
    self.shadowLine.backgroundColor = config.shadowLineCOlor;
    self.shadowLine.layer.cornerRadius = self.config.shadowLineHeight/2.f;
    if(self.config.shadowLineCap == ljwcodeShadowLineCapSquare){
        self.shadowLine.layer.cornerRadius = 0;
    }
    self.shadowLine.layer.masksToBounds = true;
    self.shadowLine.hidden = config.showShadowLineHidden;
    [self.collectionView addSubview:self.shadowLine];
    
    self.stopAnimation = false;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat collectionWidth = self.bounds.size.width;
    if(self.rightBtn){
        CGFloat btnW = self.bounds.size.height;
        collectionWidth = self.bounds.size.width - btnW;
        self.rightBtn.frame = CGRectMake(self.bounds.size.width - btnW, 0, btnW, btnW);
    }
    
    self.collectionView.frame = CGRectMake(0, 0, collectionWidth, self.bounds.size.height);
    self.separatorLine.frame = CGRectMake(0, self.bounds.size.height - self.config.separatorLineHeight, self.bounds.size.width, self.config.separatorLineHeight);
    
    [self.shadowLine setFrame:CGRectMake(15, CGRectGetMaxY(self.separatorLine.frame)-3, self.config.shadowLineWidth, self.config.shadowLineHeight)];
}

#pragma mark ------ UICollectionViewDelegate && UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource pageTitleViewNumberOfTitle];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self widthForItemAtIndexPath:indexPath], collectionView.bounds.size.height - self.config.titleViewInsets.top - self.config.titleViewInsets.bottom);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ljwcodePageTitleCollectionViewCell *cell = [self.dataSource pageTitleViewCellForItemAtIndex:indexPath.row];
    if(!cell){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ljwcodePageTitleCollectionViewCell class]) forIndexPath:indexPath];
    }
    cell.config = self.config;
    cell.textLabel.text = [self.dataSource pageTitleViewTitleAtIndex:indexPath.row];
    [cell configCellOfSelected:(indexPath.row == self.selectedIndex)];
    [self addCellModel:indexPath frame:cell.frame];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL switchSuccess = [self.delegate pageTitleViewDidSelectedAtIndex:indexPath.row];
    if(!switchSuccess){
        return;
    }
    self.selectedIndex = indexPath.row;
}

#pragma mark ------ private

-(void)addCellModel:(NSIndexPath *)indexPath frame:(CGRect)frame {
    ljwcodePageTitleCellModel *model = [[ljwcodePageTitleCellModel alloc]init];
    model.frame = frame;
    model.indexPath = indexPath;
    
    bool contain = NO;
    for(ljwcodePageTitleCellModel *model in self.cellModelArray){
        if(model.indexPath.row == indexPath.row){
            contain = YES;
        }
    }
    if(!contain) {
        [self.cellModelArray addObject:model];
    }
}

-(CGFloat)widthForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.config.titleWidth > 0){
        return self.config.titleWidth;
    }
    
    CGFloat normalTitleWidth = [ljwcodePageViewControllerUtil textForWidth:[self.dataSource pageTitleViewTitleAtIndex:indexPath.row] textFont:self.config.titleNormalFont size:self.bounds.size];
    CGFloat selectedTitleWidth = [ljwcodePageViewControllerUtil textForWidth:[self.dataSource pageTitleViewTitleAtIndex:indexPath.row] textFont:self.config.titleSelectedFont size:self.bounds.size];
    
    return selectedTitleWidth > normalTitleWidth ? selectedTitleWidth : normalTitleWidth;
}

-(CGPoint)shadowLineCenterForIndex:(NSInteger)index {
    ljwcodePageTitleCollectionViewCell *cell = (ljwcodePageTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect cellFrame = cell.frame;
    if(!cell) {
        for (ljwcodePageTitleCellModel *model in self.cellModelArray){
            if(model.indexPath.row == index) {
                cellFrame = model.frame;
            }
        }
    }
    CGFloat centerX = CGRectGetMidX(cellFrame);
    CGFloat separetorLineHeight = self.config.showSeparatorLine ? 0 : self.config.separatorLineHeight;
    CGFloat centerY = self.bounds.size.height - self.config.shadowLineHeight/2.f - separetorLineHeight;
    if(self.config.shadowLineAlignment == ljwcodeShadowLIneAniamationAlignmentTop){
        centerY = self.config.shadowLineHeight / 2.f;
    }
    if(self.config.shadowLineAlignment == ljwcodeShadowLIneAniamationAlignmentCenter) {
        centerY = CGRectGetMidY(cellFrame);
    }
    return CGPointMake(centerX, centerY);
}

-(void)reloadData {
    self.layout.haveUpdateInset = false;
    [self.collectionView reloadData];
    if(!self.config.showShadowLineHidden) {
        self.shadowLine.hidden = [self.dataSource pageTitleViewNumberOfTitle] == 0;
    }
    [self fixShadowLineCenter];
}

#pragma mark ------ Setter && getter

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self updateLayout];
}

-(void)setRightBtn:(UIButton *)rightBtn {
    _rightBtn = rightBtn;
    [self addSubview:rightBtn];
}

-(void)setAnimationProgress:(CGFloat)animationProgress {
    if(self.stopAnimation){
        return;
    }
    
    if(animationProgress == 0){
        return;
    }
    
    NSInteger targetInteger = animationProgress < 0 ? _selectedIndex - 1 : _selectedIndex + 1;
    if(targetInteger < 0 || targetInteger >= [self.dataSource pageTitleViewNumberOfTitle]){
        return;
    }
    
    ljwcodePageTitleCollectionViewCell *currentCell = (ljwcodePageTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    ljwcodePageTitleCollectionViewCell *targetCell = (ljwcodePageTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:targetInteger inSection:0]];
    
    if(self.config.titleColorTransition){
        [currentCell showAnimationOfProgress:fabs(animationProgress) cellAnimationType:ljwcodePageTitleCellAnimationTypeSelected];
        [targetCell showAnimationOfProgress:fabs(animationProgress) cellAnimationType:ljwcodePageTitleCellAnimationTypeWillSelect];
    }
    [ljwcodePageViewControllerUtil showAnimationShadow:self.shadowLine shadowWidth:self.config.shadowLineWidth fromItemRect:currentCell.frame toItemRect:targetCell.frame shadowAnimationType:self.config.shadowLineAnimationType progress:animationProgress];
}

-(void)updateLayout {
    if(_selectedIndex == _lastSelectedIndex){
        return;
    }
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:_selectedIndex inSection:0];
    ljwcodePageTitleCollectionViewCell *currentCell = (ljwcodePageTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:currentIndexPath];
    [currentCell configCellOfSelected:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView performWithoutAnimation:^{
            [self.collectionView reloadItemsAtIndexPaths:@[currentIndexPath]];
        }];
    });
    
    if(_lastSelectedIndex < [self.dataSource pageTitleViewNumberOfTitle]){
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:_lastSelectedIndex inSection:0];
        ljwcodePageTitleCollectionViewCell *lastCell = (ljwcodePageTitleCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:lastIndexPath];
        [lastCell configCellOfSelected:lastIndexPath];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView performWithoutAnimation:^{
                [self.collectionView reloadItemsAtIndexPaths:@[lastIndexPath]];
            }];
        });
    }
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    CGPoint center = [self shadowLineCenterForIndex:_selectedIndex];
    if(center.x <= 0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self fixShadowLineCenter];
        });
    }else {
        self.shadowLine.center = center;
    }
    
    _lastSelectedIndex = _selectedIndex;
    
    
}

-(void)fixShadowLineCenter {
    if(self.config.titleViewStyle == ljwcodeTitleViewStyleSegmented) {
        return;
    }
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
    CGPoint shadowCenter = [self shadowLineCenterForIndex:_selectedIndex];
    if(shadowCenter.x > 0){
        self.shadowLine.center = shadowCenter;
    }else {
        if(self.shadowLine.center.x <= 0){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.shadowLine.center = [self shadowLineCenterForIndex:self.selectedIndex];
            });
        }
    }
    
}

#pragma mark ----- 自定义cell

-(void)registerClass:(Class)class cellForTitleWithResuseIdentifier:(NSString *)identifier{
    if(!identifier.length){
        [NSException raise:@"This identifier must not be nil and must not be an empty string" format:@""];
    }
    
    if([identifier isEqualToString:NSStringFromClass([ljwcodePageTitleCollectionViewCell class])]){
        [NSException raise:@"please change an identifier" format:@""];
    }
    
    if(![class isSubclassOfClass:[ljwcodePageTitleCollectionViewCell class]]){
        [NSException raise:@"The cell class must be a subclass of ljwcodePagetitleCollectionViewCell" format:@""];
    }
    [self.collectionView registerClass:class forCellWithReuseIdentifier:identifier];
}

-(ljwcodePageTitleCollectionViewCell *)dequeueResuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index{
    if(!identifier.length){
        [NSException raise:@"This identifier must not be nil and must not be an empty string" format:@""];
    }
    
    if([identifier isEqualToString:NSStringFromClass([ljwcodePageTitleCollectionViewCell class])]){
        [NSException raise:@"please change an identifier" format:@""];
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if(!indexPath){
        [NSException raise:@"Please change an identifier" format:@""];
    }
    
    ljwcodePageTitleCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
