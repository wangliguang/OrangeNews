//
//  GG_newsTableViewCell.h
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GG_NewsCellModel.h"
@interface GG_newsTableViewCell : UITableViewCell


@property (nonatomic, retain) UIImageView *iconImageView;
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *detailLabel;
@property (nonatomic, retain) UIButton *favoritesBtn;

@property (nonatomic, retain)GG_NewsCellModel *model;

@end
