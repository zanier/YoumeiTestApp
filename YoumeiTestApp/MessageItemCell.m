//
//  MessageItemCell.m
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import "MessageItemCell.h"

@interface MessageItemCell ()

@property (nonatomic, strong) UILabel *idLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;

@end

@implementation MessageItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    CGFloat leftMargin = 16;
    CGFloat margin = 4;
    CGFloat width = 300;
    CGFloat height = 21;
    _idLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, margin, width, height)];
    [self.contentView addSubview:_idLabel];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(_idLabel.frame) + margin, width, height)];
    [self.contentView addSubview:_contentLabel];
    _createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin, CGRectGetMaxY(_contentLabel.frame) + margin, width, height)];
    [self.contentView addSubview:_createTimeLabel];
}

- (void)setItem:(MessageItem *)item {
    _item = item;
    _idLabel.text = [NSString stringWithFormat:@"ID：%@ state：%@ type：%@", item.idStr, item.state, item.type];;
    _contentLabel.text = [NSString stringWithFormat:@"content：%@", item.content];;
    _createTimeLabel.text = [NSString stringWithFormat:@"creationTime：%f", item.creationTime];
}

@end
