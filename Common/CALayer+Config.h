//
//  CALayer+Config.h
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>

@interface CALayer (Config)

/**
 *  @brief 用于xib中的运行时
 *
 *  @param color 设置borderColor
 */
- (void)setBorderColorWithUIColor:(UIColor *)color;

@end
