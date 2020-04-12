//
//  CreateMessageViewController.m
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import "CreateMessageViewController.h"
#import "UIViewController+Custom.h"
#import "MessageItem.h"
#import "HttpAPI.h"

@interface CreateMessageViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) MessageItem *item;
@property (nonatomic, copy) NSArray *typeArray;

@end

@implementation CreateMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建";
    _typeArray = @[@(0), @(1), @(2)];
    _item = [[MessageItem alloc] init];
    _item.idStr = IdString;
    self.textField.text = _item.content;
    self.typeLabel.text = [NSString stringWithFormat:@"%li", (long)_item.type];
    [self setupSubViews];
}

- (void)setupSubViews {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(finishAction:)];
    [self.view addSubview:self.tableView];
}

- (void)showSelectTypeActionSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < _typeArray.count; i++) {
        UIAlertAction *typeAction = [UIAlertAction actionWithTitle:[_typeArray[i] description] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self didSelectType:i];
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:typeAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didSelectType:(NSInteger)type {
    _item.type = @(type);
    self.typeLabel.text = [NSString stringWithFormat:@"%li", (long)_item.type];
}

- (void)finishAction:(UIBarButtonItem *)buttonItem {
    _item.content = self.textField.text;
    if (!_item.content || _item.content.length == 0) {
        [self showCenterToast:@"content 不能为空!"];
        return;
    }
    [self presentAlertViewControllerTitle:@"确定提交吗？" message:nil firstTitle:@"取消" firstAction:nil secendTitle:@"确定" secendAction:^{
        [self uploadItem];
    }];
}

- (void)uploadItem {
    [HttpAPI postMessageItem:_item succes:^(NSURLSessionDataTask * _Nonnull task, NSString * _Nonnull responseURL) {
        [self showCenterToast:@"创建成功!"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [self showCenterToast:[NSString stringWithFormat:@"创建失败! %@", error]];
    }];
}

/// MARK: - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"content";
        cell.accessoryView = self.textField;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"type";
        cell.accessoryView = self.typeLabel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

/// MARK: - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self showSelectTypeActionSheet];
    }
}

/// MARK: - getter

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 45.0f;
    _tableView.tableFooterView = [[UIView alloc] init];
    return _tableView;
}

- (UITextField *)textField {
    if (_textField) {
        return _textField;
    }
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 21)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeyDone;
    return _textField;
}

- (UILabel *)typeLabel {
    if (_typeLabel) {
        return _typeLabel;
    }
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 21)];
    return _typeLabel;
}

/// MARK: - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

@end
