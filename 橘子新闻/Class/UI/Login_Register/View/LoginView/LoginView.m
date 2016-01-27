//
//  LoginView.m
//  技术分享
//
//  Created by 呼呼 on 16/1/21.
//  Copyright © 2016年 呼呼. All rights reserved.
//

#import "LoginView.h"
#import "NSMutableDictionary+TitleTextAttributes.h"
#import "UIViewExt.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self layoutUI];
        
    }
    return self;
}

- (void)layoutUI{
    
    //选择器
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"登录",@"注册"]];
    self.segmentControl.frame = CGRectMake(-2, 0, kScreenWidth+4, 40);
    [self addSubview:self.segmentControl];
    self.segmentControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.segmentControl.tintColor = [UIColor whiteColor];
    [self.segmentControl setTitleTextAttributes:[NSMutableDictionary titleTextAttributesWithTitleColor:[UIColor grayColor] WithTiteleFont:[UIFont systemFontOfSize:15]] forState:UIControlStateNormal];
    [self.segmentControl setTitleTextAttributes:[NSMutableDictionary titleTextAttributesWithTitleColor:[UIColor blackColor] WithTiteleFont:[UIFont boldSystemFontOfSize:15]] forState:UIControlStateSelected];
    
    self.segmentControl.selectedSegmentIndex = 0;
    self.isLogin = YES;

#pragma mark segmentControl的响应
    [[self.segmentControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl *tempSegmentControl) {
        
        if (tempSegmentControl.selectedSegmentIndex == 0) {
        
            self.isLogin = YES;
            
            [self.OKBtn setTitle:@"登录" forState:UIControlStateNormal];
            
        }else{
            
            self.isLogin = NO;
            
             [self.OKBtn setTitle:@"注册" forState:UIControlStateNormal];
        }
       
        
        
    }];

    //账号输入
    self.accountTextfiled = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, self.segmentControl.bottom+10, kScreenWidth-kMargin*2, 50)];
    self.accountTextfiled.borderStyle = UITextBorderStyleNone;
    self.accountTextfiled.placeholder = @"请输入账号";
    [self addSubview:self.accountTextfiled];
    self.accountTextfiled.textAlignment = NSTextAlignmentCenter;
    self.accountTextfiled.font = [UIFont systemFontOfSize:17];
    self.accountTextfiled.delegate = self;
    
    //分割线
    UIView *lineview1 = [[UIView alloc]initWithFrame:CGRectMake(kMargin, self.accountTextfiled.bottom, kScreenWidth-kMargin*2, 1.5)];
    lineview1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineview1];
    
    
    //密码输入
    self.passwordTextfiled = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, self.accountTextfiled.bottom+10, kScreenWidth-kMargin*2, 50)];
    self.passwordTextfiled.borderStyle = UITextBorderStyleNone;
    self.passwordTextfiled.placeholder = @"请输入账号";
    [self addSubview:self.passwordTextfiled];
    self.passwordTextfiled.textAlignment = NSTextAlignmentCenter;
    self.passwordTextfiled.font = [UIFont systemFontOfSize:17];
    self.passwordTextfiled.delegate = self;
    
    //分割线
    UIView *lineview2 = [[UIView alloc]initWithFrame:CGRectMake(kMargin, self.passwordTextfiled.bottom, kScreenWidth-kMargin*2, 1.5)];
    lineview2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineview2];
    
    //OKbtn
    self.OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.OKBtn.frame = CGRectMake(kMargin, lineview2.bottom+20, kScreenWidth-kMargin*2, 50);
    self.OKBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:88/255.0 blue:31/255.0 alpha:1];
    [self addSubview:self.OKBtn];
    self.OKBtn.layer.cornerRadius = 5;
    self.OKBtn.layer.masksToBounds = YES;
    [self.OKBtn setTitle:@"登录" forState:UIControlStateNormal];
    

    
}



@end
