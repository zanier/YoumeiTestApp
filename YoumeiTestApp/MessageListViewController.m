//
//  MessageListViewController.m
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import "MessageListViewController.h"
#import "CreateMessageViewController.h"
#import "UIViewController+Custom.h"
#import "MJRefresh/MJRefresh.h"
#import "MessageItemCell.h"
#import "MessageItem.h"
#import "HttpAPI.h"

static NSInteger const limitCount = 10;

@interface MessageListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<MessageItem *> *dataArray;
@property (nonatomic, assign) NSTimeInterval timeStamp;

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Youmei-Test-App";
    [self setupSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupSubViews {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"创建" style:(UIBarButtonItemStylePlain) target:self action:@selector(gotoCreatePage)];
    [self.view addSubview:self.tableView];
}

/// MARK: - Action

- (void)refreshHeader {
    [HttpAPI getMessageListWithId:IdString limit:limitCount timeStamp:0 direction:1 succes:^(NSArray * _Nonnull itemsArray, NSTimeInterval lastCreateTime) {
        self.timeStamp = lastCreateTime;
        self.dataArray = [itemsArray mutableCopy];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self showCenterToast:[error description]];
    }];
}

- (void)refreshFooter {
    [HttpAPI getMessageListWithId:IdString limit:limitCount timeStamp:_timeStamp direction:0 succes:^(NSArray * _Nonnull itemsArray, NSTimeInterval lastCreateTime) {
        self.timeStamp = lastCreateTime;
        [self.dataArray addObjectsFromArray:itemsArray];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self showCenterToast:[error description]];
    }];
}

- (void)gotoCreatePage {
    [self.navigationController pushViewController:[[CreateMessageViewController alloc] init] animated:YES];
}

/// MARK: - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    MessageItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageItemCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.item = self.dataArray[indexPath.row];
    return cell;
}

/// MARK: - <UITableViewDelegate>

/// MARK: - getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80.0f;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_footer.automaticallyChangeAlpha = YES;
    return _tableView;
}

- (NSMutableArray<MessageItem *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
