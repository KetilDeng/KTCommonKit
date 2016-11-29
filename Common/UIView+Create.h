//
//  UIView+Create.h
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Create)

/*!
 *  @brief load from nib
 *
 *  @return nib
 */
+ (id)loadFromNib;

/*!
 *  @brief register nib
 *
 *  @return nib
 */
+ (UINib *)registerNib;

@end
