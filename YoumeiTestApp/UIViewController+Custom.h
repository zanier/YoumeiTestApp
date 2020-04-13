//
//  UIViewController+Custom.h
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Custom)

/**
*  获取当前应用的Window
*/
- (UIWindow *)superWindow;

- (void)hideCenterToast;

- (void)showCenterToast:(NSString *)text;

- (void)showCenterToast:(NSString *)text duration:(NSTimeInterval)duration;

/**
 弹出警告视图（两键）
 
 @param title 标题
 @param message 信息
 @param firstTitle 第一个按钮（取消）标题
 @param firstHandler 第一个按钮（取消）操作
 @param secendTitle 第二个按钮标题
 @param secendHandler 第二个按钮操作
 */
- (UIAlertController *)presentAlertViewControllerTitle:(NSString *)title
                                               message:(NSString *)message
                                            firstTitle:(NSString *)firstTitle
                                           firstAction:(void (^)(void))firstHandler
                                           secendTitle:(NSString *)secendTitle
                                          secendAction:(void (^)(void))secendHandler;

@end
