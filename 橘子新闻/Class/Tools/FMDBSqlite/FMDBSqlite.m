
//
//  FMDBSqlite.m
//  橘子新闻
//
//  Created by GG on 16/1/14.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "FMDBSqlite.h"

@implementation FMDBSqlite

+ (FMDatabase *)openDataBase:(NSString *)DBName{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    path = [path stringByAppendingFormat:@"/%@",DBName];
    
    NSLog(@"%@",path);
    
    //指定路径创建一个数据库
   FMDatabase *db = [FMDatabase databaseWithPath:path];
    
    return db;
    
}

+ (void)DB:(FMDatabase *)db createTable:(NSString *)creteTableSqliteStr{
    
    if([db open]) { //打开数据库  open方法会返回一个BOOL值，返回YES表明数据库打开成功
        
        BOOL result = [db executeUpdate:creteTableSqliteStr]; //创建一个表，表里有名字和年龄
        
        if(result) {
            
            NSLog(@"建表成功");
            
        }else{
            
            NSLog(@"建表失败原因%@",[db lastErrorMessage]);
            
        }
        
        [db close]; //关闭数据库
        
    }else{
        
        NSLog(@"打开数据库失败原因%@",[db lastErrorMessage]);
    }
    
}

+ (BOOL)DB:(FMDatabase *)db UpdateTable:(NSString *)updateSqliteStr {
    
    
    
    if([db open]) { //打开数据库  open方法会返回一个BOOL值，返回YES表明数据库打开成功
        
        //在表中插入数据
        BOOL result =  [db executeUpdate:updateSqliteStr];
        
        
        if(result) {
            
            [db close]; //关闭数据库
            NSLog(@"插入数据成功");
            return YES;
            
        }else{
            
            [db close]; //关闭数据库
            NSLog(@"插入数据失败原因%@",[db lastErrorMessage]);
            return NO;
            
        }
        

        
    }else{
        
        NSLog(@"打开数据库失败原因%@",[db lastErrorMessage]);
        return NO;
    }

    
    
}

//查询结束以后记得关数据库
+ (FMResultSet *)DB:(FMDatabase *)db queryData:(NSString *)querySqliteStr{
    
    if([db open]) { //打开数据库  open方法会返回一个BOOL值，返回YES表明数据库打开成功
        
        //在表中插入数据，将查询到的结果都放在FMResultSet中
        FMResultSet *result =  [db executeQuery:querySqliteStr];
        
//        [db close]; //关闭数据库
        
        return result;
        
        
    }else{
        
        NSLog(@"打开数据库失败原因%@",[db lastErrorMessage]);
        return nil;
    }
 
    
}

+ (BOOL)DB:(FMDatabase *)db isExistTable:(NSString *)tableName{
    
    NSString *sql = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'",tableName];
    
    if([db open]) { //打开数据库  open方法会返回一个BOOL值，返回YES表明数据库打开成功
        
        FMResultSet *result = [db executeQuery:sql];
       
        while ([result next])
        {
            // just print out what we've got in a number of formats.
            NSInteger count = [result intForColumn:@"count"];
            
            NSLog(@"isTableOK %ld", count);
            
            if (0 == count)
            {
                return NO;
            }
            else
            {
                return YES;
            }
        }
        
        return nil;

        
    }else{
        
        NSLog(@"打开数据库失败原因%@",[db lastErrorMessage]);
        return nil;
    }
    
    
}



@end
