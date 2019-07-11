//
//  UIViewController+NavItem.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "UIViewController+NavItem.h"

#import <objc/runtime.h>

static const void *leftBlockKey  = &leftBlockKey;
static const void *rightBlockKey = &rightBlockKey;

@implementation UIViewController (NavItem)

- (void)configNavLeftItem:(voidBlock)action{
	[self configNavLeftItem:[UIImage imageNamed:@"common_back_icon"]?:@"返回" andAction:action];
}

- (void)configNavLeftItem:(id)object andAction:(voidBlock)action{
	[self configNavItem:object leftOrRight:YES withFont:nil withItemColor:nil andAction:action];
}

- (void)configNavRightItem:(id)object andAction:(voidBlock)action{
	[self configNavItemWith:object leftOrRight:NO withFont:nil withItemColor:nil andAction:action];
}

- (void)configNavItem:(id)object leftOrRight:(BOOL)left withFont:(UIFont *)font withItemColor:(UIColor *)color andAction:(voidBlock)action{
	
	NSCAssert([object isKindOfClass:[NSString class]] || [object isKindOfClass:[UIImage class]], @"the object must be class of NSString or UIImage");
	
	if ([object isKindOfClass:[UIImage class]]) {
		if (action) {
			objc_setAssociatedObject(self, left ? &leftBlockKey : &rightBlockKey,action,OBJC_ASSOCIATION_COPY_NONATOMIC);
		}
		UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[object imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:left ? @selector(pressLeft:) : @selector(pressRight:)];
		if (left){
			self.navigationItem.leftBarButtonItem = barButtonItem;
		}else{
			self.navigationItem.rightBarButtonItem = barButtonItem;
		}
	}else {
		if (color && font) {
			[self configNavigationItemString:object withFont:font withItemColor:color leftOrRight:left andAction:action];
		}else if(color){
			[self configNavigationItemString:object withFont:[UIFont systemFontOfSize:16.0] withItemColor:color leftOrRight:left andAction:action];
		}else if (font){
			[self configNavigationItemString:object withFont:font withItemColor:nil leftOrRight:left andAction:action];
		}else{
			[self configNavigationItemString:object withFont:[UIFont systemFontOfSize:16.0] withItemColor:nil leftOrRight:left andAction:action];
		}
	}
}


- (void)configNavigationItemString:(NSString*)text withFont:(UIFont*)font withItemColor:(UIColor *)color leftOrRight:(BOOL)left andAction:(voidBlock)action{
	NSCAssert([text isKindOfClass:[NSString class]], @"the text must be class of NSString");
	
	if (action) {
		objc_setAssociatedObject(self, left ? &leftBlockKey : &rightBlockKey,
								 action,
								 OBJC_ASSOCIATION_COPY_NONATOMIC);
	}
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:left ? @selector(pressLeft:) : @selector(pressRight:)];
	NSDictionary * attributes = @{NSFontAttributeName: font};
	[barButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
	if (color) {
		[barButtonItem setTintColor:color];
	}else{
		[barButtonItem setTintColor:[UIColor whiteColor]];
	}
	if (left) {
		self.navigationItem.leftBarButtonItem = barButtonItem;
	}else {
		self.navigationItem.rightBarButtonItem = barButtonItem;
	}
}

#pragma mark - User Action
- (void)pressLeft:(id)sender{
	voidBlock action = objc_getAssociatedObject(self, leftBlockKey);
	if (action) {
		action();
	}
}

- (void)pressRight:(id)sender{
	voidBlock action = objc_getAssociatedObject(self, rightBlockKey);
	if (action) {
		action();
	}
}

@end
