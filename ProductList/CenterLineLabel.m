//
//  CenterLineLabel.m
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import "CenterLineLabel.h"

@implementation CenterLineLabel
@synthesize padex = _padex;
@synthesize leftPadding = _leftPadding;

- (void)drawRect:(CGRect)rect {
    //    if (self.padex == 0) {
    //        self.padex = 1;
    //    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextSetRGBStrokeColor(context, 255.0f/255.0f, 255.0f/255.0f, 255.0f/255.0f, 1.0f); // RGBA
    CGContextSetStrokeColorWithColor(context, self.textColor.CGColor);
    CGContextSetLineWidth(context, 1.0f);
    
    CGContextMoveToPoint(context, self.leftPadding, self.bounds.size.height/2 - self.padex);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/2 - self.padex);
    
    CGContextStrokePath(context);
    
    [super drawRect:rect];
}

@end
