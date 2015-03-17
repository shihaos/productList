//
//  MultiLineLabel.h
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//支持自行控制范围，多行显示
@interface MultiLineLabel : UILabel {
    CGFloat width;
}
@property (nonatomic, assign) CGFloat maxHeight;

@end
