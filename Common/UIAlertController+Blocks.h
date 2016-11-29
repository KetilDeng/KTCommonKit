//
//  UIAlertController+Blocks.h
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertControllerActionBlock)(UIAlertAction * _Nonnull acion, UIAlertController * _Nullable alertController);

@interface UIAlertController (Blocks)

/*!
 *  @brief 根据UIAlertControllerStyle生成alertController
 *
 *  @param title                  title
 *  @param message                message
 *  @param cancleActionTitle      cancleActionTitle
 *  @param destructiveActionTitle destructiveActionTitle
 *  @param style                  UIAlertControllerStyle
 *  @param actions                actions
 *  @param handler                handler
 *
 *  @return alertController
 */
+ (nonnull instancetype)createAlertControllerWithTitle:(nullable NSString *)title
											   message:(nullable NSString *)message
									 cancleActionTitle:(nullable NSString *)cancleActionTitle
								destructiveActionTitle:(nullable NSString *)destructiveActionTitle
												 style:(UIAlertControllerStyle)style
										   withActions:(nullable NSArray *)actions
										   withhandler:(nullable UIAlertControllerActionBlock)handler;

/*!
 *  @brief 生成UIAlertControllerStyleAlert样式的alertController
 *
 *  @param title                  title
 *  @param message                message
 *  @param cancleActionTitle      cancleActionTitle
 *  @param destructiveActionTitle destructiveActionTitle
 *  @param actions                actions
 *  @param handler                handler
 *
 *  @return alertController
 */
+ (nonnull instancetype)createAlertControllerWithTitle:(nullable NSString *)title
											   message:(nullable NSString *)message
									 cancleActionTitle:(nullable NSString *)cancleActionTitle
								destructiveActionTitle:(nullable NSString *)destructiveActionTitle
											   actions:(nullable NSArray *)actions
											   handler:(nullable UIAlertControllerActionBlock)handler;

/*!
 *  @brief 生成只含message的简单alertController
 *
 *  @param message message
 *
 *  @return alertController
 */
+ (nonnull instancetype)createAlertControllerWithmessage:(nullable NSString *)message;

/*!
 *  @brief 生成含textField的alertController
 *
 *  @param title                  title
 *  @param message                message
 *  @param cancleActionTitle      cancleActionTitle
 *  @param destructiveActionTitle destructiveActionTitle
 *  @param textFields             textFields
 *  @param actions                actions
 *  @param handler                handler
 *
 *  @return alertController
 */
+ (nonnull instancetype)createAlertControllerWithTitle:(nullable NSString *)title
											   message:(nullable NSString *)message
									 cancleActionTitle:(nullable NSString *)cancleActionTitle
								destructiveActionTitle:(nullable NSString *)destructiveActionTitle
											textFields:(nullable NSArray *)textFields
											   actions:(nullable NSArray *)actions
											   handler:(nullable UIAlertControllerActionBlock)handler;
@end
