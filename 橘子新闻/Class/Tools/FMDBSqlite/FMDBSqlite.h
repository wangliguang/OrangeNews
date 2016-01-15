//
//  FMDBSqlite.h
//  橘子新闻
//
//  Created by GG on 16/1/14.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDataBase.h"
@interface FMDBSqlite : NSObject

//打开数据库没有就新建
+ (FMDatabase *)openDataBase:(NSString *)DBName;

//创建表
+ (void)DB:(FMDatabase *)db createTable:(NSString *)creteTableSqliteStr;
//更新数据
+ (BOOL)DB:(FMDatabase *)db UpdateTable:(NSString *)updateSqliteStr ;

//查询
+ (FMResultSet *)DB:(FMDatabase *)db queryData:(NSString *)querySqliteStr;

//数据库中是否有这张表
+ (BOOL)DB:(FMDatabase *)db isExistTable:(NSString *)tableName;

@end
