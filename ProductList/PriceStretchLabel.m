//
//  PriceStretchLabel.m
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "PriceStretchLabel.h"

@implementation PriceStretchLabel

@synthesize attributedTextLayer = attributedTextLayer_;
@synthesize isBlocked = _isBlocked;

- (void)dealloc
{
    [attributedTextLayer_ removeFromSuperlayer];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [attributedTextLayer_ setNeedsDisplay];
}

- (void) setSeperatPrice:(NSString*) seperatPrice {
    //    DDLogVerbose(@"set SeperatePrice %@",seperatPrice);
    
    if (seperatPrice == nil || [seperatPrice compare:@""] == NSOrderedSame) {
        return;
    }
    
    //    [attributedTextLayer_ removeFromSuperlayer];
    //    RELEASE_SAFELY(attributedTextLayer_);
    if (attributedTextLayer_ == nil) {
        attributedTextLayer_ = [[CATextLayer alloc] init];
    }
    
    attributedTextLayer_.frame = self.bounds;
    
    [self.layer addSublayer:attributedTextLayer_];
    
    [self setAttributeTextLayerWithPrice:seperatPrice];
    
    [self setNeedsDisplay];
    
}

- (CGSize) suggestSizeAndFitRange:(CFRange*) range forAttributeString:(NSMutableAttributedString*) string usingSize:(CGSize)referenceSize {
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)string);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, [string length]), NULL, referenceSize, range);
    //HACK: There is a bug in Core Text where suggested size is not quite right
    //I'm padding it with half line height to make up for the bug.
    //see the coretext-dev list: http://web.archiveorange.com/archive/v/nagQXwVJ6Gzix0veMh09
    
    //    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)string);
    //    CGFloat ascent, descent, leading;
    //    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    //    CGFloat lineHeight = ascent + descent + leading;
    //    suggestedSize.height += lineHeight / 2.f;
    //    //End HACK
    
    CFRelease(frameSetter);
    
    return suggestedSize;
}

- (CTFontRef)newFontWithAttributes:(NSDictionary *)attributes {
    CTFontDescriptorRef descriptor = CTFontDescriptorCreateWithAttributes((CFDictionaryRef)attributes);
    CTFontRef font = CTFontCreateWithFontDescriptor(descriptor, 0, NULL);
    CFRelease(descriptor);
    return font;
}


- (void) setAttributeTextLayerWithPrice:(NSString*) price{
    static CTFontRef baseFontRef = nil;
    if (!baseFontRef) {
        NSDictionary* baseFontAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Heiti SC",@"STHeitiSC-Medium",[NSNumber numberWithFloat:12.0f],nil] forKeys:[NSArray arrayWithObjects:(id)kCTFontFamilyNameAttribute,kCTFontNameAttribute,kCTFontSizeAttribute, nil]];
        baseFontRef = [self newFontWithAttributes:baseFontAttributes];
    }
    
    static CTFontRef selectFontRef = nil;
    if (!selectFontRef) {
        NSDictionary* selectFontAttributes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Heiti SC",@"STHeitiSC-Medium",[NSNumber numberWithFloat:18.0f], nil] forKeys:[NSArray arrayWithObjects:(id)kCTFontFamilyNameAttribute,kCTFontNameAttribute,kCTFontSizeAttribute, nil]];
        selectFontRef = [self newFontWithAttributes:selectFontAttributes];
    }
    
    static NSDictionary* baseAttributes = nil;
    if (!baseAttributes) {
        baseAttributes = [NSDictionary dictionaryWithObject:(__bridge id)baseFontRef forKey:(id)kCTFontAttributeName];
    }
    
    
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:price attributes:baseAttributes];
    NSRange pointRange = [[attrString string] rangeOfString:@"."];
    if (pointRange.length > 0) {
        NSRange rangeOfClassName = NSMakeRange(1, [[attrString string] length]-4);
        //        NSRange rangeOfClassName = NSMakeRange(1, pointRange.location);
        
        [attrString addAttribute:(id)kCTFontAttributeName value:(__bridge id)selectFontRef range:rangeOfClassName];
        [attrString addAttribute:(id)kCTForegroundColorAttributeName value:(id)self.textColor.CGColor range:NSMakeRange(0, [[attrString string] length])];
        
        attributedTextLayer_.string = attrString;
        attributedTextLayer_.wrapped = YES;
        attributedTextLayer_.contentsScale = [[UIScreen mainScreen] scale]*1.2;
        CFRange fitRange;
        
        if (_isBlocked) {
            CGRect textDisplayRect = CGRectInset(CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height*3), 0, 0);
            CGSize suggestedSize = [self suggestSizeAndFitRange:&fitRange forAttributeString:attrString usingSize:textDisplayRect.size];
            [attributedTextLayer_ setValue:[NSValue valueWithCGSize:suggestedSize] forKeyPath:@"bounds.size"];
            attributedTextLayer_.anchorPoint = CGPointMake(0, 0);
            attributedTextLayer_.position = CGPointMake((self.bounds.size.width - suggestedSize.width)/2, 0);
        } else {
            CGSize suggestedSize = [self suggestSizeAndFitRange:&fitRange forAttributeString:attrString usingSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            [attributedTextLayer_ setValue:[NSValue valueWithCGSize:suggestedSize] forKeyPath:@"bounds.size"];
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, suggestedSize.width, suggestedSize.height)];
            attributedTextLayer_.anchorPoint = CGPointMake(0, 0);
            attributedTextLayer_.position = CGPointMake(0, 0);
        }
    }
}

@end

