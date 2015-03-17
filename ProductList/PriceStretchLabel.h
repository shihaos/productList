//
//  PriceStretchLabel.h
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PriceStretchLabel : UILabel

@property (nonatomic, strong) CATextLayer *attributedTextLayer;
@property (nonatomic, assign) BOOL isBlocked;

- (void) setSeperatPrice:(NSString*) seperatPrice ;

@end

