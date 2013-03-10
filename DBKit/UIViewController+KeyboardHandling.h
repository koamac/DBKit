//
//  UIViewController+KeyboardHandling.h
//  DBKitSampleApp
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBKeyboardInfo.h"

@protocol DBKitKeyboardHandlingProtocol <NSObject>
@optional
- (void)keyboardWillShow:(DBKeyboardInfo *)keyboardInfo;
- (void)keyboardDidShow:(DBKeyboardInfo *)keyboardInfo;
- (void)keyboardWillHide:(DBKeyboardInfo *)keyboardInfo;
- (void)keyboardDidHide:(DBKeyboardInfo *)keyboardInfo;

@end

@interface UIViewController (KeyboardHandling) <DBKitKeyboardHandlingProtocol>
- (void)startMonitoringKeyboardEvents;
- (void)stopMonitoringKeyboardEvents;
@end
