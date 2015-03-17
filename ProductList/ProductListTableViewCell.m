//
//  ProductListTableViewCell.m
//  ProductList
//
//  Created by shihaos on 14/11/24.
//  Copyright (c) 2014年 shihaos. All rights reserved.
//

#import "ProductListTableViewCell.h"
#define CELL_HEI_NORMAL             64
#define CELL_ICON_SIZE              50
#define CELL_TIME_FONT_SIZE         11
#define CELL_TITLE_FONT_SIZE        16

@implementation ProductListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        for (UIView * view in [self subviews])
        {
            if (view != self.contentView && view != [self.contentView superview])
            {
                [view removeFromSuperview];
            }
            
        }
        
        UIImageView *view = [[UIImageView alloc] init];
        UILabel *lLabel = [[MultiLineLabel alloc] init];
        UILabel *oLabel = [[CenterLineLabel alloc] init];
        _itemImageView = view;
        _originPriceLabel = oLabel;
        _longTitleLabel = lLabel;
        
        _longTitleLabel  = [[MultiLineLabel alloc] init];
        _originPriceLabel  = [[CenterLineLabel alloc] init];
        //_avatorView.layer.cornerRadius  = 20;
        //_avatorView.layer.masksToBounds = YES;
        
        self.longTitleLabel  = [[MultiLineLabel alloc] init];
        self.originPriceLabel  = [[CenterLineLabel alloc] init];
        
        _longTitleLabel.backgroundColor = [UIColor clearColor];
        _originPriceLabel.backgroundColor = [UIColor clearColor];
        _originPriceLabel.font = [UIFont systemFontOfSize:12];
        _longTitleLabel.textColor = [UIColor blackColor];
        _originPriceLabel.textColor = [UIColor grayColor];
        
        // 底部线条
        UIView *bankdownLine=[[UIView alloc] initWithFrame:CGRectMake(56, 53.5, 480 - 66, 0.5)];
        [bankdownLine setBackgroundColor:[UIColor blackColor]];
        [self.contentView setBackgroundColor :[UIColor whiteColor]];
        bankdownLine.tag = 10000;
        
        
        [self.contentView addSubview:bankdownLine];
        [self.contentView addSubview:_originPriceLabel];
        [self.contentView addSubview:_longTitleLabel];
    }
    return self;
}


@end
