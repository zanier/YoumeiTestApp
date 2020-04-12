//
//  HttpAPI.m
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import "HttpAPI.h"
#import "AFNetworking.h"
#import "MessageItem.h"
#import "NSObject+YYModel.h"

static NSString *const YoumeiURLString = @"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message";

@implementation HttpAPI

+ (void)postMessageItem:(MessageItem *)item
                 succes:(void (^)(NSURLSessionDataTask *task, NSString *responseURL))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:YoumeiURLString parameters:[item modelToJSONObject] constructingBodyWithBlock:nil progress:nil success:success failure:failure];
}

+ (void)getMessageListWithId:(NSString *)idStr
                       limit:(NSInteger)limit
                   timeStamp:(NSTimeInterval)lastCreateTime
                   direction:(NSInteger)direction
                 succes:(void (^)(NSArray <MessageItem *> *itemsArray, NSTimeInterval lastCreateTime))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSParameterAssert(idStr);
    NSMutableDictionary *header = @{
        @"id" : idStr,
        @"limit" : @(limit),
    }.mutableCopy;
    if (lastCreateTime > 0) {
        [header setObject:@(lastCreateTime) forKey:@"lastItem"];
    }
    if (direction == 0 || direction == 1) {
        [header setObject:@(direction) forKey:@"direction"];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:YoumeiURLString parameters:header progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if (![responseObject isKindOfClass:[NSDictionary class]] || ![responseObject valueForKey:@"data"]) {
            return;
        }
        NSDictionary *dataDic = responseObject[@"data"];
        if (![dataDic isKindOfClass:[NSDictionary class]] || ![dataDic valueForKey:@"items"]) {
            return;
        }
        NSArray *itemsArray = dataDic[@"items"];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (int i = 0; i < itemsArray.count; i++) {
            MessageItem *item = [MessageItem modelWithDictionary:itemsArray[i]];
            [mutableArray addObject:item];
        }
        NSLog(@"modelDescription: \n%@", [mutableArray modelDescription]);
        NSTimeInterval lastCreateTime = 0;
        if ([dataDic valueForKey:@"lastItem"]) {
            NSDictionary *lastItemDic = dataDic[@"lastItem"];
            if ([lastItemDic valueForKey:@"creationTime"]) {
                lastCreateTime = [lastItemDic[@"creationTime"] doubleValue];
            }
        }
        if (success) {
            success(mutableArray, lastCreateTime);
        }
    } failure:failure];
}

@end
