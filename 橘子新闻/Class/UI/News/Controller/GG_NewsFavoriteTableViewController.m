//
//  GG_NewsFavoriteViewController.m
//  橘子新闻
//
//  Created by GG on 16/1/14.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_NewsFavoriteTableViewController.h"
#import "GG_NewsCellModel.h"
#import "GG_newsTableViewCell.h"

@interface GG_NewsFavoriteTableViewController ()
{
    FMDatabase *db;

}
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation GG_NewsFavoriteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadFavoriteNewsData];
    
    self.title = @"收藏";
    
    [self.tableView registerClass:[GG_newsTableViewCell class] forCellReuseIdentifier:@"cellID"];
    
}

#pragma mark 加载数据
- (void)loadFavoriteNewsData{
    
    db = [FMDBSqlite openDataBase:@"favoriteNew.sqlite"];
    
    NSUserDefaults *defalut = [NSUserDefaults standardUserDefaults];
    
    NSString *sqliteStr = [NSString stringWithFormat:@"select * from %@", [defalut objectForKey:kCurrentUser]];
    FMResultSet *result = [FMDBSqlite DB:db queryData:sqliteStr];
    
    //通过结果集的next方法遍历结果
    while ([result next]) {
        
        GG_NewsCellModel *model = [[GG_NewsCellModel alloc]init];
        
        //通过列的下标来取数据
        model.title = [result objectForColumnName:@"title"];
        
        model.detail = [result objectForColumnName:@"detail"];
        
        model.image = [result objectForColumnName:@"image"];
        
        
        [self.dataArray addObject:model];
        
        
        
    }
    
    [self.dataArray removeObjectAtIndex:0];

    
    [db close];
}

#pragma mark UITableViewDelegate、UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GG_newsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    [cell.favoritesBtn removeFromSuperview];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
#pragma mark 懒加载
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
    
    }
    return _dataArray;
}

@end
