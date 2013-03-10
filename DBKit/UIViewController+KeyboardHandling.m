//
//  UIViewController+KeyboardHandling.m
//  DBKitSampleApp
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
//

#import "UIViewController+KeyboardHandling.h"

@implementation UIViewController (KeyboardHandling) 
- (void)startMonitoringKeyboardEvents {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(db_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(db_keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(db_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(db_keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)stopMonitoringKeyboardEvents {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [defaultCenter removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [defaultCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [defaultCenter removeObserver:self name: UIKeyboardDidHideNotification object:nil];
}

#pragma mark - Internal Notification Handling
- (void)db_keyboardWillShow:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(keyboardWillShow:)]) {
        DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
        [self keyboardWillShow:keyboardInfo];
    }

    
}

- (void)db_keyboardDidShow:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(keyboardDidShow:)]) {
        DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
        [self keyboardDidShow:keyboardInfo];
    }

}

- (void)db_keyboardWillHide:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(keyboardWillHide:)]) {
        DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
        [self keyboardWillHide:keyboardInfo];
    }

}

- (void)db_keyboardDidHide:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(keyboardDidHide:)]) {
        DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
        [self keyboardDidHide:keyboardInfo];
    }

}

@end
