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

- (void)configNavLeftItemWith:(voidBlock)action;

- (void)configNavLeftItemWith:(id)object andAction:(voidBlock)action;

- (void)configNavRightItemWith:(id)object andAction:(voidBlock)action;

- (void)configNavItemWith:(id)object leftOrRight:(BOOL)left withFont:(UIFont *)font withItemColor:(UIColor *)color andAction:(voidBlock)action;

- (void)configNavigationItemString:(NSString*)text withFont:(UIFont*)font withItemColor:(UIColor *)color leftOrRight:(BOOL)left andAction:(voidBlock)action;

@end
