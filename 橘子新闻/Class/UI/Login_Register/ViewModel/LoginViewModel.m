//
//  LoginViewModel.m
//  橘子新闻
//
//  Created by GG on 16/1/27.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

+ (void)registerAccount:(NSString *)userName WithPassword:(NSString *)password WithBlock:(void (^)(NSError *))result{
    
    //往_User表添加用户信息
    BmobObject *user = [BmobObject objectWithClassName:@"_User"];
    [user setObject:userName forKey:@"username"];
    [user setObject:password forKey:@"password"];
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        result(error);
        
    }];

}

+ (void)loginInAccount:(NSString *)userName WithPassword:(NSString *)password WithBlock:(void (^)(BmobObject *object,NSError *error))result{
    
    
    //查询_User中的数据
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];

    [bquery getObjectInBackgroundWithId:userName block:^(BmobObject *object,NSError *error){
        
        result(object,error);
    
    }];
    
    
}

@end
