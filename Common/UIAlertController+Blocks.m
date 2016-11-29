//
//  UIAlertController+Blocks.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "UIAlertController+Blocks.h"

@implementation UIAlertController (Blocks)

+ (instancetype)createAlertControllerWithmessage:(NSString *)message{
	return [self createAlertControllerWithTitle:@""
										message:message
							  cancleActionTitle:@"确定"
						 destructiveActionTitle:nil
										actions:nil
										handler:nil];
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title
									   message:(NSString *)message
							 cancleActionTitle:(NSString *)cancleActionTitle
						destructiveActionTitle:(NSString *)destructiveActionTitle
									   actions:(NSArray *)actions
									   handler:(UIAlertControllerActionBlock)handler{
	return [self createAlertControllerWithTitle:title
										message:message
							  cancleActionTitle:cancleActionTitle
						 destructiveActionTitle:destructiveActionTitle
										  style:UIAlertControllerStyleAlert
									withActions:actions
									withhandler:handler];
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title
									   message:(NSString *)message
							 cancleActionTitle:(NSString *)cancleActionTitle
						destructiveActionTitle:(NSString *)destructiveActionTitle
									textFields:(NSArray *)textFields
									   actions:(NSArray *)actions
									   handler:(UIAlertControllerActionBlock)handler{
	
	UIAlertController *alertController = [self createAlertControllerWithTitle:title
																	  message:message
															cancleActionTitle:cancleActionTitle
													   destructiveActionTitle:destructiveActionTitle
																		style:UIAlertControllerStyleAlert
																  withActions:actions
																  withhandler:handler];
	if (textFields.count) {
		for (NSString *text in textFields) {
			[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
				textField.placeholder = text;
			}];
		}
	}
	return alertController;
}

+ (instancetype)createAlertControllerWithTitle:(NSString *)title
									   message:(NSString *)message
							 cancleActionTitle:(NSString *)cancleActionTitle
						destructiveActionTitle:(NSString *)destructiveActionTitle
										 style:(UIAlertControllerStyle)style
								   withActions:(NSArray *)actions
								   withhandler:(UIAlertControllerActionBlock)handler{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
	
	UIPopoverPresentationController *popover = alertController.popoverPresentationController;
	if (popover){
		UIView *popverView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
		popover.sourceView = popverView;
		popover.sourceRect = popverView.bounds;
		popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
	}
	
	if (cancleActionTitle) {
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancleActionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
			if (handler) {
				handler(action, alertController);
			}
		}];
		[alertController addAction:cancelAction];
	}
	
	if (destructiveActionTitle) {
		UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveActionTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
			if (handler) {
				handler(action, alertController);
			}
		}];
		[alertController addAction:destructiveAction];
	}
	
	if (actions.count > 0) {
		for (NSString *actionTitle in actions) {
			UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle
															 style:UIAlertActionStyleDefault
														   handler:^(UIAlertAction * _Nonnull action) {
															   if (handler) {
																   handler(action, alertController);
															   }
														   }];
			[alertController addAction:action];
		}
	}
	
#if !__has_feature(objc_arc)
	return [alertController autorelease];
#else
	return alertController;
#endif
}

@end
