//
//  KDLine.h
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  方便在Interface Builder上拖一些线，支持横向、竖向的实线，还有横向的虚线
 */
@interface KDLine : UIView

/**
 *  线的颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *lineColor;
/**
 *  是否竖线
 */
@property (nonatomic, assign) IBInspectable BOOL vertical;
/**
 *  是否虚线模式
 */
@property (nonatomic, assign) IBInspectable BOOL dashedMode;
/**
 *  虚线间隙
 */
@property (nonatomic, assign) IBInspectable CGFloat dashedWidth;
/**
 *  线的厚度，即横线的高度或者竖线的宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat lineLength;

@end
