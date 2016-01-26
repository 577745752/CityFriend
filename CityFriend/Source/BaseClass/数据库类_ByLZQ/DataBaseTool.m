//
//  DataBaseTool.m
//  UIlesson19_数据库
//
//  Created by 李志强 on 15/7/14.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "DataBaseTool.h"

static DataBaseTool * dbHandle = nil;

@implementation DataBaseTool

static sqlite3 *db = nil;

+(instancetype) shareDataBase
{
    if (dbHandle == nil) {
        dbHandle = [[DataBaseTool alloc] init];
    }
    return dbHandle;
}

-(int)connectDB:(NSString *)filePath{
    if (db != nil) {
        return 1;
    }
    int result = sqlite3_open(filePath.UTF8String, &db);
    if (result == SQLITE_OK) {
        return 0;
    }
    else
    {
        return -1;
    }
}

-(int)disconnectDB
{
    int result = sqlite3_close(db);
    if (result != SQLITE_OK) {
        return -1;
    }
    db = nil;
    return 0;
}

-(int)execDDLSql:(NSString *)sql
{
    char * errmsg = NULL;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        return 0 ;
    }
    else
    {
        NSLog(@"%s",errmsg); // 这里应该是写日志的. mypantone
        return -1;
    }
}

-(int)execDMLSql:(NSString *)sql
{
    char * errmsg = NULL;
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, &errmsg);
    if (result == SQLITE_OK) {
        return 0 ;
    }
    else
    {
        NSLog(@"%s",errmsg); // 这里应该是写日志的. mypantone
        // rollback;
        return -1;
    }
}

-(int)sqlCount:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    int count = -1;
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            count = sqlite3_column_int(stmt, 0);
        }
    }
    sqlite3_finalize(stmt);
    return count;
}

-(NSString *)sqlFieldText:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    NSString * string = nil;
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            string = [NSString stringWithFormat:@"%s",sqlite3_column_text(stmt, 0)];
        }
    }
    sqlite3_finalize(stmt);
    return string;
}

-(NSInteger)sqlFieldInt:(NSString *)sql
{
    sqlite3_stmt * stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    NSInteger i = -1;
    
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            i = sqlite3_column_int(stmt, 0);
        }
    }
    sqlite3_finalize(stmt);
    return i;
}

-(NSMutableArray *)selectString:(NSString *)sql
{
    NSMutableArray *array = nil;
    sqlite3_stmt * stmt = nil;
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] init];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString * string = [NSString string];
            string = [NSString stringWithFormat:@"%s", sqlite3_column_text(stmt, 0)];
            [array addObject:string];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}
//向数据库中插入聊天记录
-(int)insertToTable:(NSString*)table WithChat:(Chat*)chat
{
    //设置错误码
    int result=0;
    //拼写执行的sql
    NSString*sql=[NSString stringWithFormat: @"insert into %@(name , content , time) values(?,?,?)",table];
    //声明游标//伴随指针
    sqlite3_stmt*cursor=nil;
    //开始逐一绑定参数
    if (sqlite3_prepare_v2(db, sql.UTF8String, -1, &cursor, NULL)==SQLITE_OK) {
        sqlite3_bind_text(cursor, 1, chat.name.UTF8String, -1, NULL);
        sqlite3_bind_text(cursor, 2, chat.content.UTF8String, -1, NULL);
        sqlite3_bind_text(cursor, 3, chat.time.UTF8String, -1, NULL);
        if (result==SQLITE_DONE) {
            NSLog(@"插入数据成功");
            result=SQLITE_DONE;
        }else if(result==SQLITE_CONSTRAINT)
        {
            NSLog(@"已经插入过");
            result=SQLITE_CONSTRAINT;
        }
        //关闭游标
        sqlite3_finalize(cursor);
    }else{
        NSLog(@"预执行失败");
        result= -1;
    }
    return result;
}
//从数据库中查询聊天记录
-(NSMutableArray*)selectTable:(NSString*)table WithCondition:(NSString*)condition;
{
    NSMutableArray*array=[NSMutableArray array];
    //声明伴随指针
    sqlite3_stmt*cursor=nil;
    //拼写sql
    NSString*sql=[NSString stringWithFormat:@"select name , content , time from %@ where ?",table];
    //预执行
    int result =sqlite3_prepare_v2(db, sql.UTF8String, -1, &cursor, NULL);
    //如果预执行成功则开始移动游标
    if (result==SQLITE_OK) {
        //开始绑定参数
        sqlite3_bind_text(cursor, 1, condition.UTF8String, -1, NULL);
        
        while (sqlite3_step(cursor)==SQLITE_ROW) {
            Chat*chat=[[Chat alloc]init];
            chat.name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(cursor, 0)];
            chat.content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(cursor, 1)];
            chat.time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(cursor, 2)];
            //将model加入到数据,等待数组返回
            [array addObject:chat];
            
        }
    }
    return array;
}

@end
