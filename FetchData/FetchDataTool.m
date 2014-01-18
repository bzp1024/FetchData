//
//  FetchDataTool.m
//  FetchData
//
//  Created by etouch on 14-1-17.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import "FetchDataTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFJSONRequestOperation.h"
@implementation FetchDataTool

+ (void)singleTest1{
    
    NSArray* data = @[@"http://localhost:8080/Test/HelloServlet?url=http://gkcx.eol.cn/schoolhtm/schoolAreaPoint/1267/10022/10034/10037.htm"];
    __block int count = data.count;
    for(NSString* string in data){

        if(string == nil || [string isEqualToString:@""]){
            continue;
        }
        NSString* stringUrl = string;
        NSMutableURLRequest* request  = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:stringUrl]];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                                
                                                                                                NSDictionary*  dic = JSON;
                                                                                                NSString*  schoolName = [dic objectForKey:@"schoolName"];
                                                                                                NSString*  lupuPlace = [dic objectForKey:@"lupuPlace"];
                                                                                                NSArray*       imgArray = [dic objectForKey:@"jsonArray"];
                                                                                                for(NSArray* array in imgArray){
                                                                                                    [[DBManager shared].__dbBase base_insert_school_luqu_sheng_grade:array _shcoolName:schoolName _luquPlace:lupuPlace];
                                                                                                }
                                                                                                
                                                                                                count--;
                                                                                                
                                                                                                NSLog(@"剩下%d\n",count);
                                                                                                
                                                                                            }
                                                                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                                NSLog(@"错误的连接是%@\n",request.URL.absoluteString);
                                                                                                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                                                             message:[NSString stringWithFormat:@"%@",error]
                                                                                                                                            delegate:nil
                                                                                                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                                                                [av show];
                                                                                            }];
        
        [operation start];
        
    }

}
+ (void)test1{
   
   
    NSString *plistPath = [__gDocmentPath stringByAppendingPathComponent:@"DataFile.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    NSMutableArray* tempArray = [NSMutableArray array];
    NSArray* dataArray = [[DBManager shared].__dbBase baseGetschoolShengGrade:1 _endId:45118 _flag:4];
    __block int count = dataArray.count;
    for(NSDictionary* dic in dataArray){
        NSString* wenkeluquxian = [dic objectForKey:@"likeluquxian"];
        if(wenkeluquxian == nil || [wenkeluquxian isEqualToString:@""]){
            continue;
        }
        NSString* stringUrl = [NSString stringWithFormat:@"http://localhost:8080/Test/HelloServlet?url=%@",wenkeluquxian];
        NSURL *URL = [NSURL URLWithString:stringUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary*  dic = responseObject;
            NSString*  schoolName = [dic objectForKey:@"schoolName"];
            NSString*  lupuPlace = [dic objectForKey:@"lupuPlace"];
            NSArray*       imgArray = [dic objectForKey:@"jsonArray"];
            for(NSArray* array in imgArray){
                [[DBManager shared].__dbBase base_insert_school_luqu_sheng_grade:array _shcoolName:schoolName _luquPlace:lupuPlace];
            }
            count--;
            NSLog(@"剩下%d\n",count);
            if(count == 0){
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            count--;
            NSLog(@"%@\n",operation.request.URL.absoluteString);
            [tempArray addObject:operation.request.URL.absoluteString];
            if(count == 0){
                [data setObject:tempArray forKey:@"dataKey"];
                [data writeToFile:plistPath atomically:YES];
            }
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }
    

    
    /*
     NSMutableArray *mutableOperations = [NSMutableArray array];
     for (NSURL *fileURL in filesToUpload) {
     NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     [formData appendPartWithFileURL:fileURL name:@"images[]" error:nil];
     }];
     
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
     
     [mutableOperations addObject:operation];
     }
     
     NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:@[...] progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
     NSLog(@"%lu of %lu complete", numberOfFinishedOperations, totalNumberOfOperations);
     } completionBlock:^(NSArray *operations) {
     NSLog(@"All operations in batch complete");
     }];
     [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];

     */
    
    
    
//    NSString *plistPath = [__gDocmentPath stringByAppendingPathComponent:@"DataFile.plist"];
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
//
//    NSMutableArray* tempArray = [NSMutableArray array];
//    NSArray* dataArray = [[DBManager shared].__dbBase baseGetschoolShengGrade:1 _endId:45118 _flag:3];
//    __block int count = dataArray.count;
//    for(NSDictionary* dic in dataArray){
//        NSString* wenkeluquxian = [dic objectForKey:@"wenkeluquxian"];
//        if(wenkeluquxian == nil || [wenkeluquxian isEqualToString:@""]){
//            continue;
//        }
//        NSString* stringUrl = [NSString stringWithFormat:@"http://localhost:8080/Test/HelloServlet?url=%@",wenkeluquxian];
//        NSMutableURLRequest* request  = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:stringUrl]];
//        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//                                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                                                                                
//                                                                                                NSDictionary*  dic = JSON;
//                                                                                                NSString*  schoolName = [dic objectForKey:@"schoolName"];
//                                                                                                NSString*  lupuPlace = [dic objectForKey:@"lupuPlace"];
//                                                                                                NSArray*       imgArray = [dic objectForKey:@"jsonArray"];
//                                                                                                for(NSArray* array in imgArray){
//                                                                                                    [[DBManager shared].__dbBase base_insert_school_luqu_sheng_grade:array _shcoolName:schoolName _luquPlace:lupuPlace];
//                                                                                                }
//                                                                                                count--;
//                                                                                                NSLog(@"剩下%d\n",count);
//                                                                                                if(count == 0){
//                                                                                                    
//                                                                                                }
//
//                                                                                            }
//                                                                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                                                                                NSLog(@"错误的连接是%@\n",request.URL.absoluteString);
//                                                                                                [tempArray addObject:request.URL.absoluteString];
//                                                                                                
//                                                                                                count--;
//                                                                                                if(count == 0){
//                                                                                                    [data setObject:tempArray forKey:@"dataKey"];
//                                                                                                    [data writeToFile:plistPath atomically:YES];
//
//                                                                                                }
//                                                                                            }];
//        
//        [operation start];
//        
//    }

}

+ (void)fetchData{
    

    [[self class] test1];

//    [[self class] single];
//    return;
//    NSArray*  dataArray = [[DBManager shared].__dbBase baseGetschoolGrade:1201 _endId:1500];
//    __block int count = dataArray.count;
//    for(NSDictionary* dic in dataArray){
//        NSString* stringUrl = [NSString stringWithFormat:@"http://localhost:8080/Test/HelloServlet?url=%@",[dic objectForKey:@"geshengfenshu"]];
//        NSMutableURLRequest* request  = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:stringUrl]];
//        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//                                                                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                                                                                
//                                                                                                NSDictionary*  dic = JSON;
//                                                                                                NSString*  schoolName = [dic objectForKey:@"schooName"];
//                                                                                                NSArray*       imgArray = [dic objectForKey:@"jsonArray"];
//                                                                                                if(imgArray.count < 34){
//                                                                                                    NSLog(@"%@\n",request.URL.absoluteString);
//                                                                                                }else {
//                                                                                                    for(NSDictionary*  tempDic in imgArray){
//                                                                                                        NSMutableDictionary*  lastDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
//                                                                                                        [lastDic setObject:schoolName forKey:@"schoolname"];
//                                                                                                        [[DBManager shared].__dbBase base_insert_school_luqu_grade:lastDic];
//                                                                                                    }
//                                                                                                }
//                                                                                                
//                                                                                                count--;
//                                                                                                
//                                                                                                NSLog(@"剩下%d\n",count);
//                                                                                                
//                                                                                            }
//                                                                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                                                                                NSLog(@"错误的连接是%@\n",request.URL.absoluteString);
//                                                                                                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                                                                                                             message:[NSString stringWithFormat:@"%@",error]
//                                                                                                                                            delegate:nil
//                                                                                                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                                                                                                [av show];
//                                                                                            }];
//        
//        [operation start];
//
//    }
    

}
@end
