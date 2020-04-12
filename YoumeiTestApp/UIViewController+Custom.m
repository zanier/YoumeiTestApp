//
//  UIViewController+Custom.m
//  YoumeiTestApp
//
//  Created by ZZ on 2020/4/12.
//  Copyright © 2020 zz. All rights reserved.
//

#import "UIViewController+Custom.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"

#ifndef isAnEmptyString
#define isAnEmptyString(aString)    (!aString || [aString isKindOfClass:[NSNull class]] || 0 == aString.length)
#endif

#ifndef isNotAnEmptyString
#define isNotAnEmptyString(aString) (!isAnEmptyString(aString))
#endif

@implementation UIViewController (Custom)

/**
*  获取当前应用的Window
*/
- (UIWindow *)superWindow {
    UIWindow *window = self.view.window;
    if (!window) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        window = appDelegate.window;
    }
    return window;
}

- (void)showCenterToast:(NSString *)text {
    [self.superWindow makeToast:text duration:[CSToastManager defaultDuration] position:CSToastPositionCenter style:nil];
}

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
                                          secendAction:(void (^)(void))secendHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (isNotAnEmptyString(firstTitle)) {
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            firstHandler ? firstHandler() : nil;
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:firstAction];
    }
    
    if (isNotAnEmptyString(secendTitle)) {
        UIAlertAction *secendAction = [UIAlertAction actionWithTitle:secendTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            secendHandler ? secendHandler() : nil;
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:secendAction];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

@end
