//
//  AutoWidthLabel.m
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import "AutoWidthLabel.h"
#import <UIKit/UIKit.h>

@implementation AutoWidthLabel
@synthesize height = _height;


- (void) setText:(NSString *)text{
    if (_height == 0) {
        _height = self.frame.size.height;
    }
    [super setText:text];
    CGSize maxLabelSize = CGSizeMake(CGFLOAT_MAX, _height);
    CGSize expectedLabelSize = [text sizeWithFont:self.font constrainedToSize:maxLabelSize];
    
    if (self.textAlignment == UITextAlignmentRight) {
        self.frame = CGRectMake(self.frame.origin.x - ceilf(expectedLabelSize.width) + self.frame.size.width, self.frame.origin.y, ceilf(expectedLabelSize.width), ceilf(expectedLabelSize.height));
    } else if (self.textAlignment == UITextAlignmentCenter) {
        self.frame = CGRectMake(self.frame.origin.x + (self.frame.size.width-ceilf(expectedLabelSize.width))/2, self.frame.origin.y, ceilf(expectedLabelSize.width), ceilf(expectedLabelSize.height));
    } else {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ceilf(expectedLabelSize.width), ceilf(expectedLabelSize.height));
    }
}


@end
