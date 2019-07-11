//
//  UIViewController+NavItem.h
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^voidBlock)();

@interface UIViewController (NavItem)

- (void)configNavLeftItem:(voidBlock)action;

- (void)configNavLeftItem:(id)object andAction:(voidBlock)action;

- (void)configNavRightItem:(id)object andAction:(voidBlock)action;

- (void)configNavItem:(id)object leftOrRight:(BOOL)left withFont:(UIFont *)font withItemColor:(UIColor *)color andAction:(voidBlock)action;

- (void)configNavigationItemString:(NSString*)text withFont:(UIFont*)font withItemColor:(UIColor *)color leftOrRight:(BOOL)left andAction:(voidBlock)action;

@end
