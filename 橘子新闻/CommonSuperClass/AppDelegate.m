//
//  AppDelegate.m
//  需求
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "AppDelegate.h"
#import "GG_NewsViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[GG_MainNavigationController alloc]initWithRootViewController:[[GG_NewsViewController alloc]init]];
    

    //注册bmobSDK
    [self registerBombSDK];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

#pragma mark 注册bmobSDK
- (void)registerBombSDK{
    
    //bmob注册成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSuccess) name:kBmobInitSuccessNotification object:nil];
    //注册失败的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerSuccess) name:kBmobInitFailNotification object:nil];
    
    /*
     
     * bmob现在使用的是http协议，但iOS9 以后苹果规定app内访问的网络必须是https协议。但是现在很多公司的项目使用的是HTTP协议，使用私有加密方式保证数据安全。现在也不能马上改成HTTPS协议传输。
     
     * 解决办法：在info.plist文件中配置，让app支持http协议
     1、在Info.plist中添加NSAppTransportSecurity类型Dictionary。
     2、在NSAppTransportSecurity下添加NSAllowsArbitraryLoads类型Boolean,值设为YES
     */
    
    //bomb注册
    [Bmob registerWithAppKey:@"88fdfa31e87c5d0bbfd19efa08d2a4d0"];
    
}

- (void)registerSuccess{
    
    NSLog(@"bmob注册成功");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBmobInitSuccessNotification object:nil];
}

- (void)registrerFailure{
    
    NSLog(@"bmob注册失败");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBmobInitFailNotification object:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
