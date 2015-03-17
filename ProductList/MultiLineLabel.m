//
//  MultiLineLabel.m
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import "MultiLineLabel.h"


@implementation MultiLineLabel
@synthesize maxHeight = _maxHeight;

- (void) setText:(NSString *)text{
    if (width == 0) {
        width = self.frame.size.width;
    }
    [super setText:text];
    if (_maxHeight == 0) {
        _maxHeight = CGFLOAT_MAX;
    }
    CGSize maxLabelSize = CGSizeMake(width, _maxHeight);
    
    static char flags = 0x00;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selector = @selector(boundingRectWithSize:options:attributes:context:);
        if ([@"a" respondsToSelector:selector]) {
            flags |= 0x0F;
        }
    });
    
    if (flags & 0x0F) {
        CGSize expectedLabelSize = [text boundingRectWithSize:maxLabelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.font} context:nil].size;
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, expectedLabelSize.width, expectedLabelSize.height);
        
    } else {
        CGSize expectedLabelSize = [text sizeWithFont:self.font constrainedToSize:maxLabelSize];
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, expectedLabelSize.width, expectedLabelSize.height);
    }
}

@end

