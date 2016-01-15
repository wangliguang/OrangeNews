//
//  NSMutableDictionary+TitleTextAttributes.m
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "NSMutableDictionary+TitleTextAttributes.h"

@implementation NSMutableDictionary (TitleTextAttributes)

+ (NSMutableDictionary *)titleTextAttributesWithTitleColor:(UIColor *)titleColor WithTiteleFont:(UIFont *)titleFont{
    
  
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[NSForegroundColorAttributeName] = titleColor;
    dict[NSFontAttributeName] = titleFont;
    
    return dict;    
}


@end
