//
//  DBManager.m
//  XExample
//
//  Created by XZoscar on 13-2-19.
//  Copyright (c) 2013年 etouch. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

@synthesize __dbBase;
//single mode
+ (DBManager *)shared
{
    @synchronized (self) {
        static DBManager *__dbManager = nil;
        if (nil == __dbManager) {
            __dbManager = [[DBManager alloc] init];
        }
        
        return __dbManager;
    }
}

- (DBBaseHelper *)dbBase
{
    @synchronized (__dbBase) {
        if (nil == __dbBase) {
            __dbBase = [[DBBaseHelper alloc] init];
        }
        return __dbBase;
    }
}
@end
