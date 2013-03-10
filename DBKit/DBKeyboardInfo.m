//
//  DBKeyboardInfo.m
//  DBKitSampleApp
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
//

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
