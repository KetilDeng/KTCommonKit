//
//  UIView+Create.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "UIView+Create.h"

@implementation UIView (Create)

+ (id)loadFromNib
{
	NSString *xibName = NSStringFromClass([self class]);
	return [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject];
}

+ (UINib *)registerNib
{
	NSString *xibName = NSStringFromClass([self class]);
	return [UINib nibWithNibName:xibName bundle:nil];
}

@end
