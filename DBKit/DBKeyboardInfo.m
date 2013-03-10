//
//  DBKeyboardInfo.m
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

#import "DBKeyboardInfo.h"

@interface DBKeyboardInfo ()
@property (assign, nonatomic) UIViewAnimationCurve animationCurve;
@property (assign, nonatomic) CGFloat animationDuration;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGRect beginningFrame;
@property (assign, nonatomic) CGRect endFrame;

@property (assign, nonatomic) CGSize rawSize;
@property (assign, nonatomic) CGRect rawBeginningFrame;
@property (assign, nonatomic) CGRect rawEndFrame;
@end

@implementation DBKeyboardInfo
+ (DBKeyboardInfo *)keyboardInfoWithNotificationDictionary:(NSDictionary *)dictionary forViewController:(UIViewController *)viewController {
    DBKeyboardInfo *keyboardInfo = [DBKeyboardInfo new];
    
    keyboardInfo.animationCurve = [dictionary[UIKeyboardAnimationCurveUserInfoKey] intValue];
    keyboardInfo.animationDuration = [dictionary[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    keyboardInfo.rawBeginningFrame = [dictionary[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardInfo.rawEndFrame = [dictionary[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardInfo.rawSize = keyboardInfo.rawBeginningFrame.size;
    
    UIView *view = viewController.view;
    keyboardInfo.beginningFrame = [view convertRect:keyboardInfo.rawBeginningFrame fromView:nil];
    keyboardInfo.endFrame = [view convertRect:keyboardInfo.rawEndFrame fromView:nil];
    keyboardInfo.size = keyboardInfo.beginningFrame.size;
    
    return keyboardInfo;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Animatione Curve: %d\nDuration: %f\n\nSize: %@\nBeginning Frame: %@\nEnd Frame: %@\n\nRaw Size: %@\nRaw Beginning Frame: %@,\nRaw End Frame: %@",
            self.animationCurve,
            self.animationDuration,
            NSStringFromCGSize(self.size),
            NSStringFromCGRect(self.beginningFrame),
            NSStringFromCGRect(self.endFrame),
            NSStringFromCGSize(self.rawSize),
            NSStringFromCGRect(self.rawBeginningFrame),
            NSStringFromCGRect(self.rawEndFrame)];
}
@end
