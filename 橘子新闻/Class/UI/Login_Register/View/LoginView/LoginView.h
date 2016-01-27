//
//  LoginView.h
//  技术分享
//
//  Created by 呼呼 on 16/1/21.
//  Copyright © 2016年 呼呼. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMargin 20

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface LoginView : UIView<UITextFieldDelegate>

@property (nonatomic,retain) UISegmentedControl *segmentControl;

@property (nonatomic,retain) UITextField *accountTextfiled;

@property (nonatomic,retain) UITextField *passwordTextfiled;

@property (nonatomic,retain) UIButton *OKBtn;

@property (nonatomic,assign) BOOL isLogin;



@end
