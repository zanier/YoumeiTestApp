//
//  MessageItemCell.h
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageItemCell : UITableViewCell

@property (nonatomic, strong) MessageItem *item;

@end

NS_ASSUME_NONNULL_END
