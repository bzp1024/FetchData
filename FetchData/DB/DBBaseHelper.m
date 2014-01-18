//
//  DBBaseHelper.m
//  TongNianProject
//
//  Created by etouch on 13-12-25.
//  Copyright (c) 2013年 etouch. All rights reserved.
//

#import "DBBaseHelper.h"

@implementation DBBaseHelper
- (id)init{
    if (self = [super init]){
        if (NULL == __dbHander) {
            NSString *dbPath = [NSString stringWithFormat:@"%@/%@",__gDocmentPath,@"MyDB"];
            int retVal = sqlite3_open_v2([dbPath UTF8String],&__dbHander,SQLITE_OPEN_READWRITE|SQLITE_OPEN_CREATE|SQLITE_OPEN_FULLMUTEX,NULL);
            if (SQLITE_OK == retVal) {
                //创建表
                [self createTable];
            }
        }
    }
    return self;
}

- (void)createTable{
    
    NSString *sql = nil;
    int retVal = -1;
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS \
           '%@' (\
           '%@' INTEGER PRIMARY KEY AUTOINCREMENT, \
           '%@'  TEXT,\
           '%@'  TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT)"
           ,@"EntranceTable",@"id",@"place",@"year",@"subject",@"xueli",@"grade"];
    retVal = sqlite3_exec(__dbHander,[sql UTF8String],NULL,NULL,NULL);
    if (SQLITE_OK != retVal) {
        
    }
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS \
           '%@' (\
           '%@' INTEGER PRIMARY KEY AUTOINCREMENT, \
           '%@'  TEXT,\
           '%@'  TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT)"
           ,@"SchoolTable",@"id",@"name",@"place",@"xueli",@"jiaoyubu",@"985gonc",@"211gongc"];
    retVal = sqlite3_exec(__dbHander,[sql UTF8String],NULL,NULL,NULL);
    if (SQLITE_OK != retVal) {
        
    }

    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS \
           '%@' (\
           '%@' INTEGER PRIMARY KEY AUTOINCREMENT, \
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT)"
           ,@"SchoolGradeTable",@"id",@"shcoolname",@"schoolplace",@"geshengfenshu",@"gezhuanyefenshu"];
    retVal = sqlite3_exec(__dbHander,[sql UTF8String],NULL,NULL,NULL);
    if (SQLITE_OK != retVal) {
        
    }
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS \
           '%@' (\
           '%@' INTEGER PRIMARY KEY AUTOINCREMENT, \
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT)"
           ,@"SchoolPlaceLuQuXianTable",@"id",@"shcoolname",@"luquPlace",@"wenkeluquxian",@"likeluquxian",@"zongheluquxian",@"yishuleiluquxian",@"tiyuleiluquxian"];
    retVal = sqlite3_exec(__dbHander,[sql UTF8String],NULL,NULL,NULL);
    if (SQLITE_OK != retVal) {
        
    }
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS \
           '%@' (\
           '%@' INTEGER PRIMARY KEY AUTOINCREMENT, \
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT,\
           '%@' TEXT)"
           ,@"SchoolPlaceShengLuQuXianTable",@"id",@"shcoolname",@"luquPlace",@"luquyear",@"highestgrade",@"avggrade",@"shengkonggrade",@"kaoshengleibie",@"luqupici"];
    retVal = sqlite3_exec(__dbHander,[sql UTF8String],NULL,NULL,NULL);
    if (SQLITE_OK != retVal) {
        
    }
    
    
}

- (BOOL)base_insert_school_luqu_sheng_grade:(NSArray*)array _shcoolName:(NSString*)schoolName _luquPlace:(NSString*)luquPlace{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' \
                     ('%@','%@','%@','%@','%@','%@','%@','%@') VALUES\(?,?,?,?,?,?,?,?)",@"SchoolPlaceShengLuQuXianTable",@"shcoolname",@"luquPlace",@"luquyear",@"highestgrade",@"avggrade",@"shengkonggrade",@"kaoshengleibie",@"luqupici"];
    sqlite3_stmt *stmt;
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return NO;
    }
    
    sqlite3_bind_text(stmt, 1,  [schoolName UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 2,  [luquPlace UTF8String],-1,NULL);
    for(int  i = 0; i < array.count; i++){
        NSString* value = [array objectAtIndex:i];
        if([value isEqualToString:@"--"]){
            value =  @"";
        }
        sqlite3_bind_text(stmt, i + 3,  [value UTF8String],-1,NULL);
    }
    if (SQLITE_DONE != sqlite3_step(stmt)) {
        sqlite3_finalize(stmt);
        return NO;
    }else {
        
        sqlite3_finalize(stmt);
        return YES;
    }
    sqlite3_finalize(stmt);
    return YES;
}

- (BOOL)base_insert_school_luqu_grade:(NSDictionary*)dic{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' \
                     ('%@','%@','%@','%@','%@','%@','%@') VALUES\
                     (?,?,?,?,?,?,?)",@"SchoolPlaceLuQuXianTable",@"shcoolname",@"luquPlace",@"wenkeluquxian",@"likeluquxian",@"zongheluquxian",@"yishuleiluquxian",@"tiyuleiluquxian"];
    sqlite3_stmt *stmt;
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return NO;
    }
    sqlite3_bind_text(stmt, 1,  [[dic objectForKey:@"schoolname"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 2,  [[dic objectForKey:@"place"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 3,  [[dic objectForKey:@"wenke"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 4,  [[dic objectForKey:@"like"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 5,  [[dic objectForKey:@"zonghe"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 6,  [[dic objectForKey:@"yishulei"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 7,  [[dic objectForKey:@"tiyulei"] UTF8String],-1,NULL);
    
    if (SQLITE_DONE != sqlite3_step(stmt)) {
        sqlite3_finalize(stmt);
        return NO;
    }else {
        
        sqlite3_finalize(stmt);
        return YES;
    }
    sqlite3_finalize(stmt);
    return YES;
}





- (BOOL)base_insert_sc:(NSArray*)array{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' \
                     ('%@','%@','%@','%@','%@','%@') VALUES\
                     (?,?,?,?,?,?)",@"SchoolTable",@"name",@"place",@"xueli",@"jiaoyubu",@"985gonc",@"211gongc"];
    sqlite3_stmt *stmt;
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return NO;
    }
    int i = 1;
    for(NSString*  xx  in array){
        if([xx isEqualToString:@"×"]){
            sqlite3_bind_text(stmt, i,  [@"" UTF8String],-1,NULL);
        }else {
            sqlite3_bind_text(stmt, i,  [xx UTF8String],-1,NULL);
        }
        i++;
    }
    if (SQLITE_DONE != sqlite3_step(stmt)) {
        sqlite3_finalize(stmt);
        return NO;
    }else {
        
        sqlite3_finalize(stmt);
        return YES;
    }
    sqlite3_finalize(stmt);
    return YES;
}

- (BOOL)base_insert_en:(NSArray*)array{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' \
                     ('%@','%@','%@','%@','%@') VALUES\
                     (?,?,?,?,?)",@"EntranceTable",@"place",@"year",@"subject",@"xueli",@"grade"];
    sqlite3_stmt *stmt;
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return NO;
    }
    
    int i = 1;
    for(NSString*  xx  in array){
        sqlite3_bind_text(stmt, i,  [xx UTF8String],-1,NULL);
        i++;
    }
    if (SQLITE_DONE != sqlite3_step(stmt)) {
        sqlite3_finalize(stmt);
        return NO;
    }else {
     
        sqlite3_finalize(stmt);
        return YES;
    }
    sqlite3_finalize(stmt);
    return YES;
}

- (BOOL)base_insert_school_grade:(NSDictionary*)dic{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO '%@' \
                     ('%@','%@','%@','%@') VALUES\
                     (?,?,?,?)",@"SchoolGradeTable",@"shcoolname",@"schoolplace",@"geshengfenshu",@"gezhuanyefenshu"];
    sqlite3_stmt *stmt;
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return NO;
    }

    
    sqlite3_bind_text(stmt, 1,  [[dic objectForKey:@"schoolname"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 2,  [[dic objectForKey:@"schoolplace"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 3,  [[dic objectForKey:@"geshengfenshu"] UTF8String],-1,NULL);
    sqlite3_bind_text(stmt, 4,  [[dic objectForKey:@"gezhuanyefenshu"] UTF8String],-1,NULL);

    if (SQLITE_DONE != sqlite3_step(stmt)) {
        sqlite3_finalize(stmt);
        return NO;
    }else {
        
        sqlite3_finalize(stmt);
        return YES;
    }
    sqlite3_finalize(stmt);
    return YES;
}



- (NSArray*)baseGetschoolShengGrade:(int)start_id _endId:(int)endId _flag:(int)flag{
    
    sqlite3_exec(__dbHander, [@"BEGIN TRANSACTION" UTF8String], NULL, NULL, NULL);
    NSString* sql = [NSString stringWithFormat:@"select * from SchoolPlaceLuQuXianTable where id >= %d and id <= %d",start_id,endId];
    sqlite3_stmt *stmt;
    
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return nil;
    }
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt, 0)] forKey:@"id"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] forKey:@"shcoolname"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] forKey:@"luquPlace"];
        if([[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, flag)] isEqualToString:@""]){
            continue;
        }
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)] forKey:@"wenkeluquxian"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)] forKey:@"likeluquxian"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 5)] forKey:@"zongheluquxian"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 6)] forKey:@"yishuleiluquxian"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 7)] forKey:@"tiyuleiluquxian"];
        [retArray addObject:dic];
    }
    sqlite3_finalize(stmt);
    sqlite3_exec(__dbHander, [@"COMMIT TRANSACTION" UTF8String], NULL, NULL, NULL);
    return retArray;
}

- (NSArray*)baseGetschoolGrade:(int)start_id _endId:(int)endId{
    
    sqlite3_exec(__dbHander, [@"BEGIN TRANSACTION" UTF8String], NULL, NULL, NULL);
    NSString* sql = [NSString stringWithFormat:@"select * from SchoolGradeTable where id >= %d and id <= %d",start_id,endId];
    sqlite3_stmt *stmt;
    
    int retVal = sqlite3_prepare_v2(__dbHander,[sql UTF8String],-1,&stmt,NULL);
    if (SQLITE_OK != retVal) {
        sqlite3_finalize(stmt);
        return nil;
    }
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        
        NSMutableDictionary* dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%d",sqlite3_column_int(stmt, 0)] forKey:@"id"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)] forKey:@"shcoolname"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)] forKey:@"schoolplace"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)] forKey:@"geshengfenshu"];
        [dic setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 4)] forKey:@"gezhuanyefenshu"];
        [retArray addObject:dic];
    }
    sqlite3_finalize(stmt);
    sqlite3_exec(__dbHander, [@"COMMIT TRANSACTION" UTF8String], NULL, NULL, NULL);
    return retArray;
}



@end
