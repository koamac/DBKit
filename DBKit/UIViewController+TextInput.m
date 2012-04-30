//
//  UIViewController+TextInput.m
//  DBKit
//
//  Created by David Barry on 4/30/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UIViewController+TextInput.h"

@implementation UIViewController (TextInput)
- (void)dismissKeyboard {
    [self dismissKeyboardForView:self.view];
}

- (void)dismissKeyboardForView:(UIView *)theView {
    [theView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIResponder class]]) {
            UIResponder *responder = obj;
            if ([responder isFirstResponder]) {
                [responder resignFirstResponder];
                *stop = YES;
            }
        }
    }];
}

@end
