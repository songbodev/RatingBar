//
//  SONGRatingBar.h
//  RatingBarDemo
//
//  Created by songbo on 15/10/22.
//  Copyright © 2015年 上海电信理想集团. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int const SONGRatingBarMinimumRating;
extern int const SONGRatingBarMaximumRating;

@interface SONGRatingBar : UIControl
/**
 *  评分分数
 */
@property (nonatomic) CGFloat rating;
/**
 *  五角星之间的缝隙，默认为5.0
 */
@property (nonatomic) float margin;
/**
 *  是否允许半颗星评分,默认为NO
 */
@property (nonatomic) BOOL allowHalfRating;
/**
 *  是否显示空星,默认为YES
 */
@property (nonatomic) BOOL showEmptyStar;
/**
 *  是否只用于显示，默认为NO
 */
@property (nonatomic) BOOL isIndicator;
/**
 *  未选中状态的五角星图片名称
 */
@property (nonatomic, copy) NSString *normalStarImageName;
/**
 *  半颗星状态的五角星图片名称
 */
@property (nonatomic, copy) NSString *halfStarImageName;
/**
 *  选中状态的五角星图片名称
 */
@property (nonatomic, copy) NSString *highlightedStarImageName;
/**
 *
 *  @param normalStarImageName      未选中状态的五角星图片名称
 *  @param highlightedStarImageName 选中状态的五角星图片名称
 *
 */
- (instancetype)initWithNormalStarImageName:(NSString *)normalStarImageName highlightedStarImageName:(NSString *)highlightedStarImageName   DEPRECATED_ATTRIBUTE;
/**
 *  指定初始化方法
 *
 *  @param normalStarImageName      未选中状态的五角星图片名称
 *  @param halfStarImageName        半颗星状态的五角星图片名称
 *  @param highlightedStarImageName 选中状态的五角星图片名称
 *
 */
- (instancetype)initWithNormalStarImageName:(NSString *)normalStarImageName halfStarImageName:(NSString *)halfStarImageName highlightedStarImageName:(NSString *)highlightedStarImageName;

@end
