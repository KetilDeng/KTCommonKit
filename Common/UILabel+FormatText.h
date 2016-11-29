//
//  UILabel+FormatText.h
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FormatText)

/*!
 *  @brief 设置属性
 *
 *  @param attributes 属性
 *  @param range      设置范围
 */
- (void)addAttributes:(NSDictionary *)attributes range:(NSRange)range;
/*!
 *  @brief 设置字体颜色
 *
 *  @param textColor 字体颜色
 *  @param range     设置范围
 */
- (void)setTextColor:(UIColor *)textColor range:(NSRange)range;
/*!
 *  @brief 设置字体大小
 *
 *  @param font  字号
 *  @param range 设置范围
 */
- (void)setFont:(UIFont *)font range:(NSRange)range;
/*!
 *  @brief 设置行距
 *
 *  @param space 设置行距
 */
- (void)setLineSpace:(CGFloat)space;

/*!
 *  @brief 根据内容获取label高度
 *
 *  @return 高度
 */
- (CGFloat)contentHeight NS_AVAILABLE_IOS(7_0);

- (CGSize)contentSize;

@end
