//
//  NSMutableDictionary+TitleTextAttributes.h
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableDictionary (TitleTextAttributes)


/*
 * 带有字体颜色和字体大小的字典
 */
+ (NSMutableDictionary *)titleTextAttributesWithTitleColor:(UIColor *)titleColor WithTiteleFont:(UIFont *)titleFont;

@end
