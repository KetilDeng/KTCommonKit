//
//  UIViewController+NavItem.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "UIViewController+NavItem.h"

#import <objc/runtime.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0                                                                                                         alpha:a]
#define LeftItemImageOrTitle [UIImage imageNamed:@"common_back_icon"]?[UIImage imageNamed:@"common_back_icon"]:@""
#define DefaultBarTintColor RGBA(255.0, 85.0, 20, 1.0)
#define DefaultTitleFont [UIFont systemFontOfSize:19.0]
#define DefaultTitleColor [UIColor whiteColor]
#define DefaultItemTitleFont [UIFont systemFontOfSize:16.0]
#define DefaultItemTintColor [UIColor whiteColor]

static const void *leftBlockKey  = &leftBlockKey;
static const void *rightBlockKey = &rightBlockKey;

@implementation UIViewController (NavItem)

- (void)configNavLeftItemWith:(voidBlock)action{
	[self configNavLeftItemWith:LeftItemImageOrTitle andAction:action];
}

- (void)configNavLeftItemWith:(id)object andAction:(voidBlock)action{
	[self configNavItemWith:object leftOrRight:YES withFont:nil withItemColor:nil andAction:action];
}

- (void)configNavRightItemWith:(id)object andAction:(voidBlock)action{
	[self configNavItemWith:object leftOrRight:NO withFont:nil withItemColor:nil andAction:action];
}

- (void)configNavItemWith:(id)object leftOrRight:(BOOL)left withFont:(UIFont *)font withItemColor:(UIColor *)color andAction:(voidBlock)action{
	
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
			[self configNavigationItemString:object withFont:DefaultItemTitleFont withItemColor:color leftOrRight:left andAction:action];
		}else if (font){
			[self configNavigationItemString:object withFont:font withItemColor:nil leftOrRight:left andAction:action];
		}else{
			[self configNavigationItemString:object withFont:DefaultItemTitleFont withItemColor:nil leftOrRight:left andAction:action];
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
		[barButtonItem setTintColor:DefaultItemTintColor];
	}
	if (left) {
		self.navigationItem.leftBarButtonItem = barButtonItem;
	}else {
		self.navigationItem.rightBarButtonItem = barButtonItem;
	}
}

#pragma mark -
#pragma mark -------------------- User Action ---------------------
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
