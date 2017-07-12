//
//  SONGRatingBar.m
//  RatingBarDemo
//
//  Created by songbo on 15/10/22.
//  Copyright © 2015年 上海电信理想集团. All rights reserved.
//

#import "SONGRatingBar.h"

int const SONGRatingBarMinimumRating = 1;
int const SONGRatingBarMaximumRating = 5;
float const SONGRatingStarMarginDefault = 5.0;
NSString *const SONGNormalStarImageNameDefault = @"ratingInactive";
NSString *const SONGHighlightedStarImageNameDefault = @"ratingActive";

@interface SONGRatingBar ()

@property (nonatomic, copy) NSArray *imageViews;

@end

@implementation SONGRatingBar

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
    
    //注意此处不能如下写法，如下写法会导致在[super init]方法执行时，因调用指定初始化方法而调用[self initWithFrame:frame],导致song_ratingBarCommonInitWithFrame方法会在此init方法返回之前调用两次，导致星星图片被添加两次出现问题。
//    self = [super init];
//    if (self) {
//        [self song_ratingBarCommonInitWithFrame:CGRectZero];
//    }
//    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self song_ratingBarCommonInitWithFrame:self.frame];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self song_ratingBarCommonInitWithFrame:self.frame];
    }
    return self;
}

- (instancetype)initWithNormalStarImageName:(NSString *)normalStarImageName highlightedStarImageName:(NSString *)highlightedStarImageName{
    return [self initWithNormalStarImageName:normalStarImageName halfStarImageName:nil highlightedStarImageName:highlightedStarImageName];
}

- (instancetype)initWithNormalStarImageName:(NSString *)normalStarImageName halfStarImageName:(NSString *)halfStarImageName highlightedStarImageName:(NSString *)highlightedStarImageName{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _normalStarImageName = [normalStarImageName copy];
        _halfStarImageName = [halfStarImageName copy];
        _highlightedStarImageName = [highlightedStarImageName copy];
        [self song_ratingBarCommonInitWithFrame:self.frame];
    }
    return self;
}

- (void)song_ratingBarCommonInitWithFrame:(CGRect)frame{
    _rating = SONGRatingBarMinimumRating - 1;
    _margin = SONGRatingStarMarginDefault;
    _allowHalfRating = NO;
    _showEmptyStar = YES;
    _isIndicator = NO;
    
//    _normalStarImageName = (_normalStarImageName?:SONGNormalStarImageNameDefault);
//    _highlightedStarImageName = (_highlightedStarImageName?:SONGHighlightedStarImageNameDefault);
//    _halfStarImageName = (_halfStarImageName?:_highlightedStarImageName);
    
    //frame
    [self setFrame:frame];
    
    NSMutableArray *imageViews = [NSMutableArray array];
    for (int index = SONGRatingBarMinimumRating; index <= SONGRatingBarMaximumRating; index++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = YES;
        [imageView setImage:[UIImage imageNamed:_normalStarImageName]];
        [self addSubview:imageView];
        [imageViews addObject:imageView];
    }
    _imageViews = [imageViews copy];
    [self updateStarsFrame];
    //[self updateImageViews];
}

- (void)updateStarsFrame{
    UIImage *normalStarImage = [UIImage imageNamed:_normalStarImageName];
    UIImage *highlightedStarImage = [UIImage imageNamed:_highlightedStarImageName];
    CGFloat starWidth = MAX(normalStarImage.size.width, highlightedStarImage.size.width);
    CGFloat starHeight = MAX(normalStarImage.size.height, highlightedStarImage.size.height);
    CGFloat starOriginY = (self.bounds.size.height - starHeight) / 2.0;
    
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull imageView, NSUInteger imageViewIndex, BOOL * _Nonnull stop) {
        [imageView setFrame:CGRectMake(_margin / 2 + (_margin + starWidth) * imageViewIndex, starOriginY, starWidth, starHeight)];
    }];
}

#pragma mark - setters
-(void)setRating:(CGFloat)rating{
    if (_rating != rating) {
        _rating = rating;
        [self updateImageViews];
    }
}

-(void)setShowEmptyStar:(BOOL)showEmptyStar{
    if (_showEmptyStar != showEmptyStar) {
        _showEmptyStar = showEmptyStar;
        [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull imageView, NSUInteger imageViewIndex, BOOL * _Nonnull stop) {
            imageView.hidden = !showEmptyStar;
        }];
        self.rating = _rating;
    }
}

-(void)setMargin:(float)margin{
    if (_margin != margin) {
        _margin = margin;
        [self setFrame:[self frame]];
        [self updateStarsFrame];
    }
}

-(void)setNormalStarImageName:(NSString *)normalStarImageName{
    if (![_normalStarImageName isEqualToString:normalStarImageName]) {
        UIImage *originalImage = [UIImage imageNamed:_normalStarImageName];
        
        _normalStarImageName = [normalStarImageName copy];
//        [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull imageView, NSUInteger imageViewIndex, BOOL * _Nonnull stop) {
//            [imageView setImage:[UIImage imageNamed:_normalStarImageName]];
//        }];
        
        UIImage *newImage = [UIImage imageNamed:normalStarImageName];
        if (!CGSizeEqualToSize(originalImage.size, newImage.size)) {
            [self setFrame:[self frame]];
            [self updateStarsFrame];
        }
    }
}

-(void)setHalfStarImageName:(NSString *)halfStarImageName{
    if (![_halfStarImageName isEqualToString:halfStarImageName]) {
        _halfStarImageName = [halfStarImageName copy];
    }
}

- (void)setHighlightedStarImageName:(NSString *)highlightedStarImageName{
    if (![_highlightedStarImageName isEqualToString:highlightedStarImageName]) {
        UIImage *originalImage = [UIImage imageNamed:_highlightedStarImageName];
        
        _highlightedStarImageName = [highlightedStarImageName copy];
//        [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull imageView, NSUInteger imageViewIndex, BOOL * _Nonnull stop) {
//            [imageView setHighlightedImage:[UIImage imageNamed:_highlightedStarImageName]];
//        }];
        
        UIImage *newImage = [UIImage imageNamed:highlightedStarImageName];
        if (!CGSizeEqualToSize(originalImage.size, newImage.size)) {
            [self setFrame:[self frame]];
            [self updateStarsFrame];
        }
    }
}

-(void)setIsIndicator:(BOOL)isIndicator {
    if (_isIndicator != isIndicator) {
        _isIndicator = isIndicator;
        //保证在ratingBar为只读状态时不会截取其他手势或事件
        self.userInteractionEnabled = !_isIndicator;
    }
}

#pragma mark - private methods
- (void)updateImageViews{
    NSInteger fullStars = floor(self.rating);
    [self.imageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull imageView, NSUInteger imageViewIndex, BOOL * _Nonnull stop) {
        imageView.hidden = NO;
        if (SONGRatingBarMinimumRating + imageViewIndex <= fullStars) {
            imageView.image = [UIImage imageNamed:_highlightedStarImageName];
        } else if (self.rating - fullStars >= 0.5 && self.rating - fullStars < 1 && SONGRatingBarMinimumRating + imageViewIndex == fullStars + 1) {
            if (_allowHalfRating) {
                imageView.image = [UIImage imageNamed:_halfStarImageName];
            } else {
                imageView.image = [UIImage imageNamed:_highlightedStarImageName];
            }
        } else {
            if (!_showEmptyStar) {
                imageView.hidden = YES;
            }
            imageView.image = [UIImage imageNamed:_normalStarImageName];
        }
    }];
}

- (void)updateRatingWithTouches:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isIndicator) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self];
    if (position.x < _margin / 2) {
        self.rating = SONGRatingBarMinimumRating - 1;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        return;
    }
    UIView *touchedView = [self hitTest:position withEvent:event];
    if ([self.imageViews containsObject:touchedView]) {
        if (_allowHalfRating && position.x <= touchedView.center.x) {
            self.rating = [self.imageViews indexOfObject:touchedView] + SONGRatingBarMinimumRating - 0.5;
        } else {
            self.rating = [self.imageViews indexOfObject:touchedView] + SONGRatingBarMinimumRating;
        }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - override

-(void)setFrame:(CGRect)frame{
    //任何初始化方法都会执行此方法，故在此处设置图片名称默认值,防止没有设置的情况下某些初始化方法会导致控制台打印出“CUICatalog: Invalid asset name supplied: (null)”的错误提示
    _normalStarImageName = (_normalStarImageName?:SONGNormalStarImageNameDefault);
    _highlightedStarImageName = (_highlightedStarImageName?:SONGHighlightedStarImageNameDefault);
    _halfStarImageName = (_halfStarImageName?:_highlightedStarImageName);
    
    UIImage *normalStarImage = [UIImage imageNamed:_normalStarImageName];
    UIImage *highlightedStarImage = [UIImage imageNamed:_highlightedStarImageName];
    
    CGFloat starWidth = MAX(normalStarImage.size.width, highlightedStarImage.size.width);
    CGFloat minimumRatingBarWidth = (SONGRatingBarMaximumRating - SONGRatingBarMinimumRating + 1) * (_margin + starWidth);
    CGFloat minimumRatingBarHeight = MAX(normalStarImage.size.height, highlightedStarImage.size.height);
    
    CGFloat ratingBarWidth = MAX(frame.size.width, minimumRatingBarWidth);
    CGFloat ratingBarHeight = MAX(frame.size.height, minimumRatingBarHeight);
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, ratingBarWidth, ratingBarHeight)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self updateRatingWithTouches:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self updateRatingWithTouches:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
}

@end
