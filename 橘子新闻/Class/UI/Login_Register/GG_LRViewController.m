//
//  GG_LRViewController.m
//  橘子新闻
//
//  Created by GG on 16/1/14.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_LRViewController.h"

#define kMargin 20

@interface GG_LRViewController ()<UITextFieldDelegate>
{
    UISegmentedControl *segmentControl;
    
    UITextField *accountTextfiled;
    UITextField *passwordTextfiled;
    
    NSString *accountStr;
    NSString *passwordStr;
    
    BOOL isLogin;
    
    UIButton *OKBtn;
    
    FMDatabase *db;
    
    MBProgressHUD *hud;
}
@end

@implementation GG_LRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"登录";
    
    [self layoutView];
}

#pragma mark layoutView
- (void)layoutView{
    
    //选择器
    segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"登录",@"注册"]];
    segmentControl.frame = CGRectMake(-2, 64, kScreenWidth+4, 40);
    [self.view addSubview:segmentControl];
    segmentControl.tintColor = [UIColor groupTableViewBackgroundColor];
    [segmentControl setTitleTextAttributes:[NSMutableDictionary titleTextAttributesWithTitleColor:[UIColor grayColor] WithTiteleFont:[UIFont systemFontOfSize:15]] forState:UIControlStateNormal];
    [segmentControl setTitleTextAttributes:[NSMutableDictionary titleTextAttributesWithTitleColor:[UIColor blackColor] WithTiteleFont:[UIFont boldSystemFontOfSize:15]] forState:UIControlStateSelected];
    [segmentControl addTarget:self action:@selector(clickSegmentControl:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    isLogin = YES;
    
    

    
    //账号输入
    accountTextfiled = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, segmentControl.bottom+10, kScreenWidth-kMargin*2, 50)];
    accountTextfiled.borderStyle = UITextBorderStyleNone;
    accountTextfiled.placeholder = @"请输入账号";
    [self.view addSubview:accountTextfiled];
    accountTextfiled.textAlignment = NSTextAlignmentCenter;
    accountTextfiled.font = [UIFont systemFontOfSize:17];
    accountTextfiled.delegate = self;
    
    //分割线
    UIView *lineview1 = [[UIView alloc]initWithFrame:CGRectMake(kMargin, accountTextfiled.bottom, kScreenWidth-kMargin*2, 1.5)];
    lineview1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineview1];
    
    
    //密码输入
    passwordTextfiled = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, accountTextfiled.bottom+10, kScreenWidth-kMargin*2, 50)];
    passwordTextfiled.borderStyle = UITextBorderStyleNone;
    passwordTextfiled.placeholder = @"请输入账号";
    [self.view addSubview:passwordTextfiled];
    passwordTextfiled.textAlignment = NSTextAlignmentCenter;
    passwordTextfiled.font = [UIFont systemFontOfSize:17];
    passwordTextfiled.delegate = self;
    
    //分割线
    UIView *lineview2 = [[UIView alloc]initWithFrame:CGRectMake(kMargin, passwordTextfiled.bottom, kScreenWidth-kMargin*2, 1.5)];
    lineview2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lineview2];
    
    
    OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    OKBtn.frame = CGRectMake(kMargin, lineview2.bottom+20, kScreenWidth-kMargin*2, 50);
    OKBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:88/255.0 blue:31/255.0 alpha:1];
    [self.view addSubview:OKBtn];
    OKBtn.layer.cornerRadius = 5;
    OKBtn.layer.masksToBounds = YES;
    [OKBtn setTitle:@"登录" forState:UIControlStateNormal];
    [OKBtn addTarget:self action:@selector(clickOKBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark 事件
- (void)clickOKBtn{
    
    [accountTextfiled resignFirstResponder];
    [passwordTextfiled resignFirstResponder];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if (isLogin == YES) {
        
        hud.labelText = @"正在登录";
        [self loginAccount];
        
    }else{
        
        hud.labelText = @"正在注册";
        [self registerAccount];
        
    }
    
    
}

- (void)delayHide{
    
}

- (void)loginAccount{
    
    db = [FMDBSqlite openDataBase:@"favoriteNew.sqlite"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%@User",accountStr] forKey:kCurrentUser];
    
    
    NSString *queryTableName = [NSString stringWithFormat:@"%@User",accountStr];
    
    if ([FMDBSqlite DB:db isExistTable:queryTableName]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:queryTableName forKey:kCurrentUser];
        
        NSString *sqliteStr = [NSString stringWithFormat:@"SELECT * FROM %@",queryTableName];
        FMResultSet *result = [FMDBSqlite DB:db queryData:sqliteStr];
        
        while ([result next]) {
            
            if ([accountStr isEqualToString:[result objectForColumnName:@"account"]] && [passwordStr isEqualToString:[result objectForColumnName:@"password"]]  ) {
                
                [hud showAnimated:YES whileExecutingBlock:^{
                    
                    sleep(0.5);
                    
                }];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } ;
        }
        
        
    }else{
        
        
        [hud showAnimated:YES whileExecutingBlock:^{
            
            sleep(2);
            hud.labelText = @"登录失败";
            sleep(0.5);
            
        }];
        

        

    }
    
    [db close];
    
}


- (void)registerAccount{
    
    hud.labelText = @"正在注册";
    
    db = [FMDBSqlite openDataBase:@"favoriteNew.sqlite"];
    
    NSString *createSqliteStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@User (account text, password text,title text, detail text, image text);",accountStr];
    [FMDBSqlite DB:db createTable:createSqliteStr];
    
    NSString *updateSqliteStr = [NSString stringWithFormat:@"INSERT INTO %@User (account, password,title,detail,image) VALUES ('%@','%@','%@','%@','%@');",accountStr,accountStr,passwordStr,nil,nil,nil];
    
    if ([FMDBSqlite DB:db UpdateTable:updateSqliteStr] == YES){
        
        [hud showAnimated:YES whileExecutingBlock:^{
            
            sleep(2);
            hud.labelText = @"注册成功";
            sleep(0.5);
            
            
        }];
        
        
    }else{
        
        [hud showAnimated:YES whileExecutingBlock:^{
            
            sleep(2);
            hud.labelText = @"注册失败";
            sleep(0.5);
            
        }];

        
        
    }
    

    
}

- (void)clickSegmentControl:(UISegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        
        isLogin = YES;
        [OKBtn setTitle:@"登录" forState:UIControlStateNormal];
        
    }else{
        
        isLogin = NO;
        [OKBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
}


#pragma mark UITextFiledDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == accountTextfiled) {
        
        accountStr = textField.text;
        
    }else{
        
        passwordStr = textField.text;
    }
    
}


@end
