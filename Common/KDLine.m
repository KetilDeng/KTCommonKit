//
//  KDLine.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "KDLine.h"

#import "UIView+Utils.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@implementation KDLine

- (void)awakeFromNib{
	
	[super awakeFromNib];
	
	if (!self.lineColor) {
		self.lineColor = self.dashedMode ? RGB(135, 135, 135) : RGB(199, 199, 199);
	}
	self.lineLength = MAX(0.5, self.lineLength);
	if (self.dashedMode) {
		self.backgroundColor = [UIColor clearColor];
		if (self.dashedWidth <= 0) {
			self.dashedWidth = 2;
		}
	}
	if (_vertical) {
		if(!self.widthConstraint){
			self.translatesAutoresizingMaskIntoConstraints = NO;
			NSLayoutConstraint *widthContraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.lineLength];
			[self addConstraint:widthContraint];
		}
		self.widthConstraint.constant = self.lineLength;
	}else {
		if (!self.heightConstraint) {
			self.translatesAutoresizingMaskIntoConstraints = NO;
			NSLayoutConstraint *heightContraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.lineLength];
			[self addConstraint:heightContraint];
		}
		self.heightConstraint.constant = self.lineLength;
	}
}

- (void)drawRect:(CGRect)rect {
	// Drawing code
	CGContextRef context =UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);
	CGContextSetLineWidth(context, self.lineLength);
	CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
	CGFloat lengths[] = {self.dashedWidth,self.dashedWidth};
	if (self.dashedMode) {
		CGContextSetLineDash(context, 0, lengths,2);
	}
	if (_vertical) {
		CGContextMoveToPoint(context, self.width/2, 0);
		CGContextAddLineToPoint(context, self.width/2,self.height);
	}else {
		CGContextMoveToPoint(context, 0, self.height/2);
		CGContextAddLineToPoint(context, self.width,self.height/2);
	}
	CGContextClosePath(context);
	CGContextStrokePath(context);
}

- (NSLayoutConstraint*)widthConstraint
{
	for (NSLayoutConstraint *constraint in self.constraints) {
		if (constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual) {
			return constraint;
		}
	}
	return nil;
}

- (NSLayoutConstraint*)heightConstraint
{
	for (NSLayoutConstraint *constraint in self.constraints) {
		if (constraint.firstAttribute == NSLayoutAttributeHeight && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual) {
			return constraint;
		}
	}
	return nil;
}

@end
