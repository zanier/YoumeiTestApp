//
//  MessageItem.h
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel/NSObject+YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageItem : NSObject

@property (nonatomic, copy) NSString *idStr;                // 用户名
@property (nonatomic, copy) NSString *content;              // 内容
@property (nonatomic, nullable, strong) NSNumber *type;     // 类型
@property (nonatomic, nullable, strong) NSNumber *state;    // 状态
@property (nonatomic, assign) NSTimeInterval creationTime;  // 毫秒级时间戳

@end

NS_ASSUME_NONNULL_END
