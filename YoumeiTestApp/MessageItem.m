//
//  MessageItem.m
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import "MessageItem.h"

@implementation MessageItem

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"idStr" : @"id",
    };
}


@end
