//
//  CALayer+Config.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "CALayer+Config.h"

@implementation CALayer (Config)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
	self.borderColor = color.CGColor;
}

@end
