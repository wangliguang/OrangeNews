//
//  GG_LRViewController.m
//  橘子新闻
//
//  Created by GG on 16/1/14.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_LRViewController.h"
#import "LoginView.h"
#import "LoginViewModel.h"

#define kMargin 20

@interface GG_LRViewController ()<UITextFieldDelegate>
{
    //进度条
    MBProgressHUD *hud;
    
    //登录试图
    LoginView *loginView;
}
@end

@implementation GG_LRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"登录";
    
    [self layoutView];
}

#pragma mark layoutView
- (void)layoutView{
    
     loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight-64)];
    
    [self.view addSubview:loginView];
    
    [[loginView.OKBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [loginView.accountTextfiled resignFirstResponder];
        [loginView.passwordTextfiled resignFirstResponder];
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if (loginView.isLogin == YES) {
            
            hud.labelText = @"正在登录";
            [self loginAccount];
            
        }else{
            
            hud.labelText = @"正在注册";
            [self registerAccount];
            
        }
        
    }];
    
}




- (void)loginAccount{
    
    
    [LoginViewModel loginInAccount:loginView.accountTextfiled.text WithPassword:loginView.passwordTextfiled.text WithBlock:^(BmobObject *object, NSError *error) {
       
        if (error == nil) {
          
            hud.labelText = @"登录成功";
            return;
        }else{
        
            hud.labelText = error.userInfo[@"error"];
            
        }
        
        
        
        [hud hide:YES afterDelay:0.5];
        
    }];

}
- (void)registerAccount {
    
    
   [LoginViewModel registerAccount:loginView.accountTextfiled.text WithPassword:loginView.passwordTextfiled.text WithBlock:^(NSError *error) {
      
       if (error == nil) {

           hud.labelText = @"注册成功";

       }else {
       
         hud.labelText = error.userInfo[@"error"];
       
       }
       
       [hud hide:YES afterDelay:0.5];
       
   }];
    
}



@end
