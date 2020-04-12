//
//  HttpAPI.h
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MessageItem;

NS_ASSUME_NONNULL_BEGIN

@interface HttpAPI : NSObject

+ (void)postMessageItem:(MessageItem *)item
                 succes:(void (^)(NSURLSessionDataTask *task, NSString *responseURL))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)getMessageListWithId:(NSString *)idStr
                       limit:(NSInteger)limit
                   timeStamp:(NSTimeInterval)lastCreateTime
                   direction:(NSInteger)direction
                      succes:(void (^)(NSArray <MessageItem *> *itemsArray, NSTimeInterval lastCreateTime))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
