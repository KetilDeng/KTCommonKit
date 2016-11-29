//
//  UILabel+FormatText.m
//  KDCommonKit
//
//  Created by Ketil on 16/11/13.
//  Copyright © 2016年 fumi. All rights reserved.
//

#import "UILabel+FormatText.h"

@implementation UILabel (FormatText)

- (void)addAttributes:(NSDictionary *)attributes range:(NSRange)range {
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
	[text addAttributes:attributes range:range];
	[self setAttributedText: text];
}

- (void)setTextColor:(UIColor *)textColor range:(NSRange)range
{
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
	[text addAttribute: NSForegroundColorAttributeName
				 value: textColor
				 range: range];
	
	[self setAttributedText: text];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
	[text addAttribute: NSFontAttributeName
				 value: font
				 range: range];
	
	[self setAttributedText: text];
}

- (void)setLineSpace:(CGFloat)space
{
	NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineSpacing = space;
	[text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
	[self setAttributedText: text];
}

- (CGFloat)contentHeight{
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
	
	paragraphStyle.lineBreakMode = self.lineBreakMode;
	
	NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:self.font,
							  NSFontAttributeName,
							  paragraphStyle,
							  NSParagraphStyleAttributeName,
							  nil];
	
	CGRect lblRect = [self.text boundingRectWithSize:(CGSize){self.frame.size.width, MAXFLOAT}
											 options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading
										  attributes:attrDict
											 context:nil];
	return lblRect.size.height;
}

- (CGSize)contentSize
{
	NSString *content = self.text;
	UIFont *font = self.font;
	CGSize size = CGSizeMake(MAXFLOAT, 0.0f);
	
	CGSize labelSize = [content boundingRectWithSize:size
											 options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
										  attributes:@{ NSFontAttributeName:font}
											 context:nil].size;
	return labelSize;
}

@end
