//
//  UIViewController+KeyboardHandling.m
//  DBKit
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
    DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
    
    if ([self respondsToSelector:@selector(keyboardWillShow:)]) [self keyboardWillShow:keyboardInfo];

    if ([self respondsToSelector:@selector(scrollViewToAutomaticallyAdjust)]) {
        UIScrollView *scrollView = [self scrollViewToAutomaticallyAdjust];
        CGFloat keyboardOverlapInScrollView = MAX(CGRectGetMaxY(scrollView.frame) - keyboardInfo.endFrame.origin.y, 0.0f);
        
        UIEdgeInsets contentInset = scrollView.contentInset;
        contentInset.bottom += keyboardOverlapInScrollView;
        
        UIEdgeInsets scrollIndicatorInset = scrollView.scrollIndicatorInsets;
        scrollIndicatorInset.bottom += keyboardOverlapInScrollView;

        UIView *firstResponder = nil;
        CGPoint contentOffset = scrollView.contentOffset;
        BOOL shouldScroll = NO;
        
        if ([self respondsToSelector:@selector(currentFirstResponder)]) {
            firstResponder = [self currentFirstResponder];
            CGRect firstResponderFrame = [firstResponder convertRect:firstResponder.bounds toView:self.view];
            CGFloat firstResponderMaxY = CGRectGetMaxY(firstResponderFrame);
            
            CGFloat viewPadding = 10.0f;
            
            if ((firstResponderMaxY + viewPadding) > keyboardInfo.endFrame.origin.y) {
                shouldScroll = YES;
                CGFloat distanceToScroll = floorf((firstResponderMaxY + viewPadding) - keyboardInfo.endFrame.origin.y);
                contentOffset.y += distanceToScroll;
            }
        }
        
        [UIView animateWithDuration:keyboardInfo.animationDuration delay:0.0f options:keyboardInfo.animationCurve animations:^{
            scrollView.contentInset = contentInset;
            scrollView.scrollIndicatorInsets = scrollIndicatorInset;
            if (shouldScroll) scrollView.contentOffset = contentOffset;
        } completion:nil];

    }
}

- (void)db_keyboardDidShow:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(keyboardDidShow:)]) {
        DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
        [self keyboardDidShow:keyboardInfo];
    }

}

- (void)db_keyboardWillHide:(NSNotification *)notification {
    DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
    
    if ([self respondsToSelector:@selector(keyboardWillHide:)]) [self keyboardWillHide:keyboardInfo];
    
    if ([self respondsToSelector:@selector(scrollViewToAutomaticallyAdjust)]) {
        UIScrollView *scrollView = [self scrollViewToAutomaticallyAdjust];
        CGFloat keyboardOverlapInScrollView = MAX(CGRectGetMaxY(scrollView.frame) - keyboardInfo.beginningFrame.origin.y, 0.0f);
        
        UIEdgeInsets contentInset = scrollView.contentInset;
        contentInset.bottom -= keyboardOverlapInScrollView;
        
        UIEdgeInsets scrollIndicatorInset = scrollView.scrollIndicatorInsets;
        scrollIndicatorInset.bottom -= keyboardOverlapInScrollView;
        
        [UIView animateWithDuration:keyboardInfo.animationDuration delay:0.0f options:keyboardInfo.animationCurve animations:^{
            scrollView.contentInset = contentInset;
            scrollView.scrollIndicatorInsets = scrollIndicatorInset;
        } completion:nil];
    }

}

- (void)db_keyboardDidHide:(NSNotification *)notification {
    if ([self respondsToSelector:@selector(keyboardDidHide:)]) {
        DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo keyboardInfoWithNotificationDictionary:notification.userInfo forViewController:self];
        [self keyboardDidHide:keyboardInfo];
    }
}

@end
