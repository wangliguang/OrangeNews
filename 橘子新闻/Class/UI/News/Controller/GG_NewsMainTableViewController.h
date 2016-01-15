//
//  GG_NewsMainTableViewController.h
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GG_NewsMainTableViewController : UITableViewController

@property (nonatomic,strong) NSDictionary *dataDict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
