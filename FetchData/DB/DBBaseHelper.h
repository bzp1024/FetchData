//
//  DBBaseHelper.h
//  TongNianProject
//
//  Created by etouch on 13-12-25.
//  Copyright (c) 2013年 etouch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBBaseHelper : NSObject{
    @private
        sqlite3 *__dbHander;
}


- (BOOL)base_insert_en:(NSArray*)array;
- (BOOL)base_insert_sc:(NSArray*)array;
- (BOOL)base_insert_school_grade:(NSDictionary*)dic;

- (BOOL)base_insert_school_luqu_grade:(NSDictionary*)dic;

- (BOOL)base_insert_school_luqu_sheng_grade:(NSArray*)array _shcoolName:(NSString*)schoolName _luquPlace:(NSString*)luquPlace;
- (NSArray*)baseGetschoolGrade:(int)start_id _endId:(int)endId;

- (NSArray*)baseGetschoolShengGrade:(int)start_id _endId:(int)endId _flag:(int)flag;
@end
