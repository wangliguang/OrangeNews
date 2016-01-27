//
//  LoginViewModel.h
//  橘子新闻
//
//  Created by GG on 16/1/27.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

//注册账号
+ (void)registerAccount:(NSString *)userName WithPassword:(NSString *)password WithBlock:(void (^)(NSError *error))result;

//登录账号
+ (void)loginInAccount:(NSString *)userName WithPassword:(NSString *)password WithBlock:(void (^)(BmobObject *object,NSError *error))result;

@end
