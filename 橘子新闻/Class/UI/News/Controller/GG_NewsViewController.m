//
//  NewsViewController.m
//  需求
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_NewsViewController.h"
#import "GG_NewsFavoriteTableViewController.h"
#import "GG_LRViewController.h"
#import "GG_NewsMainTableViewController.h"

#define kTypeSelectedViewH  35



@interface GG_NewsViewController()<UIScrollViewDelegate>
{

    UIScrollView *newsTypeSelectScrollView;
    UIScrollView *newsTypeShowScrollView;
    UISegmentedControl *newsTypeSelectSegmentControl;
    
    NSDictionary  *dict;
}

@end

@implementation GG_NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"橘子新闻";
    
    [self loadData];
    
    [self addSelectNewsTypeView];
    
    [self addNewShowView];
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftItem)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}

#pragma mark 各种事件
- (void)clickRightItem{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:kCurrentUser] == nil) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"您尚未登录";
        
        [hud showAnimated:YES whileExecutingBlock:^{
            
            sleep(2);
            
        }];
        
        return;
    }
    
    [self.navigationController pushViewController:[[GG_NewsFavoriteTableViewController alloc]init] animated:YES];
    
}

- (void)clickLeftItem{
    
    [self.navigationController pushViewController:[[GG_LRViewController alloc]init] animated:YES];
}


#pragma mark 加载数据
- (void)loadData{
    
    /*
     * 真正的项目中，咱会给后台传一个分类参数，根据这个参数后台给咱们返回相应的数据。
     * 而在此由于咱们没有后台，所以所有分类下的新闻 我用的是用一个plist文件的数据。谅解。。。
    */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"plist"];
    
    dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
}

#pragma mark 创建试图
- (void)addSelectNewsTypeView{
    
    //新闻类型选择scrollow
    newsTypeSelectScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth,kTypeSelectedViewH)];
//    newsTypeSelectScrollView.delegate = self;
    newsTypeSelectScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newsTypeSelectScrollView];
    
    
    //设置各种新闻类型的segmentcontro
    NSArray *itemsArray = @[@"头条",@"NBA",@"手机",@"移动互联",@"娱乐",@"时尚",@"电影",@"科技"];
    newsTypeSelectSegmentControl = [[UISegmentedControl alloc]initWithItems:itemsArray];
    newsTypeSelectSegmentControl.apportionsSegmentWidthsByContent = YES;
    newsTypeSelectSegmentControl.tintColor = [UIColor clearColor];
    
    [newsTypeSelectSegmentControl setTitleTextAttributes:[NSMutableDictionary titleTextAttributesWithTitleColor:[UIColor blackColor] WithTiteleFont:[UIFont systemFontOfSize:15]] forState:UIControlStateNormal];
    [newsTypeSelectSegmentControl setTitleTextAttributes:[NSMutableDictionary titleTextAttributesWithTitleColor:[UIColor redColor] WithTiteleFont:[UIFont systemFontOfSize:21]] forState:UIControlStateSelected];
    [newsTypeSelectSegmentControl sizeToFit];
    newsTypeSelectSegmentControl.selectedSegmentIndex = 0;
    [newsTypeSelectScrollView addSubview:newsTypeSelectSegmentControl];
    newsTypeSelectScrollView.contentSize = CGSizeMake(CGRectGetWidth(newsTypeSelectSegmentControl.frame), 0);
    
    [newsTypeSelectSegmentControl addTarget:self action:@selector(clickSegmentControl:) forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)addNewShowView{
    
    newsTypeShowScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+CGRectGetHeight(newsTypeSelectScrollView.frame), kScreenWidth, kScreenHeight-64-CGRectGetMaxY(newsTypeShowScrollView.frame))];
    newsTypeShowScrollView.backgroundColor = [UIColor grayColor];
    newsTypeShowScrollView.contentSize = CGSizeMake(newsTypeSelectSegmentControl.numberOfSegments*kScreenWidth, 0);
    
    newsTypeShowScrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:newsTypeShowScrollView];
    newsTypeShowScrollView.pagingEnabled = YES;
    newsTypeShowScrollView.delegate = self;
    
    
    for (int index = 0; index<newsTypeSelectSegmentControl.numberOfSegments; index++) {
    
        GG_NewsMainTableViewController *tableVC = [[GG_NewsMainTableViewController alloc]initWithDict:dict];
        
        [self addChildViewController:tableVC];
        
        tableVC.tableView.frame = CGRectMake(index*kScreenWidth,0 , kScreenWidth, CGRectGetHeight(newsTypeShowScrollView.frame));
        
        [newsTypeShowScrollView addSubview:tableVC.tableView];
    }
    
}


//点击segmentControl
- (void)clickSegmentControl:(UISegmentedControl *)sender{
    
    
    newsTypeShowScrollView.contentOffset = CGPointMake([sender selectedSegmentIndex]*kScreenWidth, 0);
    
    
    
}


#pragma mark UIScrollowDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    int index = floor(scrollView.contentOffset.x/kScreenWidth);
    
    NSLog(@"%f",scrollView.contentOffset.x);
    
    [UIView animateWithDuration:0.15 animations:^{
        
        newsTypeSelectSegmentControl.selectedSegmentIndex = index;
        
    }];
    
    
    if (index == floor(newsTypeSelectSegmentControl.numberOfSegments/2)) {
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGFloat index = CGRectGetWidth(newsTypeSelectSegmentControl.frame)-kScreenWidth;
            
            newsTypeSelectScrollView.contentOffset = CGPointMake(index, 0);
            
            
        }];
    }else if(index == floor(newsTypeSelectSegmentControl.numberOfSegments/2)-1){
        
        newsTypeSelectScrollView.contentOffset = CGPointMake(0, 0);
        
    }
    
    
}






@end
