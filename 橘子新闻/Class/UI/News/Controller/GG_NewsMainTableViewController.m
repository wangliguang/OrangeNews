//
//  GG_NewsMainTableViewController.m
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_NewsMainTableViewController.h"
#import "GG_newsTableViewCell.h"
#import "GG_NewsCellModel.h"
#import "GG_HeadlineScrollView.h"
#import "GG_NewsHeadModel.h"

#define kHeadlineScrollViewH 200

@interface GG_NewsMainTableViewController ()
{
    NSMutableArray *headlineArray;
    NSMutableArray *newsArray;
    
    NSUInteger page;
    
    GG_HeadlineScrollView *headlineScrollView;
    
    FMDatabase *db;
    
}

//这个数组里面要放两个数组，每个数组存放这该页的model数据
@property (nonatomic,strong) NSMutableArray *allDataArray;

//cell真正的数据源数组
@property (nonatomic,strong) NSMutableArray *dataArray;

//表头真正的数据源数组
@property (nonatomic,strong) NSMutableArray *headlineDataArray;

@end

@implementation GG_NewsMainTableViewController

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.dataDict = dict;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    headlineArray = self.dataDict[@"HeadlineArray"];
    newsArray = self.dataDict[@"NewsArray"];
    
    self.allDataArray = [NSMutableArray array];
    
    for (NSArray *array in newsArray) {
        
        NSMutableArray *tempArray = [GG_NewsCellModel mj_objectArrayWithKeyValuesArray:array];
        
        [self.allDataArray addObject:tempArray];
        
    }
    
    self.headlineDataArray = [NSMutableArray array];
    for (NSDictionary *dict in headlineArray) {
        
        [self.headlineDataArray addObject:[GG_NewsHeadModel mj_objectWithKeyValues:dict]];
        
    }
    
    

    [self.tableView registerClass:[GG_newsTableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    page = 0;
    
    [self loadData:page];
    
    [self headerAndFooterFresh];
    
    [self setupTableViewHeaderView];
    
    
}

#pragma mark 头条新闻试图
- (void)setupTableViewHeaderView{
    
    headlineScrollView = [[GG_HeadlineScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeadlineScrollViewH) WithArray:self.headlineDataArray];

    headlineScrollView.contentSize = CGSizeMake(headlineArray.count*kScreenWidth, 0);
    headlineScrollView.pagingEnabled = YES;
    headlineScrollView.showsHorizontalScrollIndicator = NO;
    self.tableView.tableHeaderView = headlineScrollView;
    
}


#pragma mark 刷新
- (void)headerAndFooterFresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArray removeAllObjects];
        sleep(2);
        [self loadData:0];
        
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        sleep(2);
        [self loadData:++page];
    }];
}



#pragma mark 加载数据
- (void)loadData:(NSUInteger)index{
    
    NSUInteger count = self.allDataArray.count;
    
    if (index < count) {
       
        [self.dataArray addObjectsFromArray:self.allDataArray[index]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        
    }else{
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    
    
}


#pragma mark UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GG_newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.favoritesBtn.tag = indexPath.row;
    [cell.favoritesBtn addTarget:self action:@selector(clickFavorites:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

#pragma mark privateMethod
- (void)clickFavorites:(UIButton *)sender{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:kCurrentUser] == nil) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"您尚未登录";
        
        [hud showAnimated:YES whileExecutingBlock:^{
           
            sleep(2);
            
        }];
        
        return;
    }
    
    db = [FMDBSqlite openDataBase:@"favoriteNew.sqlite"];
    
    GG_NewsCellModel *model = self.dataArray[sender.tag];
    NSString *insertSqliteStr = [NSString stringWithFormat:@"INSERT INTO %@ (account,password,title, detail, image) VALUES ('%@','%@','%@','%@','%@');",[defaults objectForKey:kCurrentUser],nil,nil,model.title,model.detail,model.image];
   
    [FMDBSqlite DB:db UpdateTable:insertSqliteStr];
    
    
}

#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}


@end
