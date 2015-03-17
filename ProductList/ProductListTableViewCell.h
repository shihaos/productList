//
//  ProductListTableViewCell.h
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiLineLabel.h"
#import "PriceStretchLabel.h"
#import "CenterLineLabel.h"

@interface ProductListTableViewCell : UITableViewCell

@property (nonatomic, retain)  UIImageView* itemImageView;
@property (nonatomic, retain)  MultiLineLabel* longTitleLabel;
@property (nonatomic, retain)  PriceStretchLabel* activePriceLabel;
@property (nonatomic, retain)  CenterLineLabel* originPriceLabel;
@property (nonatomic, retain)  AutoWidthLabel* numPaidLabel;
@end
