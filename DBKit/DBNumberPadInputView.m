//
//  DBNumberPadInputView.m
//  DBKit
//
//  Created by David Barry on 1/31/12.
//  Copyright (c) 2011 David Barry
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

#import <UIKit/UIKit.h>
#import "DBNumberPadInputView.h"
#import "UIView+DBKit.h"

@interface DBNumberPadInputView ()
@property (nonatomic, strong) NSTimer *deleteRepeatTimer;
- (void)sendDeleteButtonPress;
@end

@implementation DBNumberPadInputView

- (IBAction)buttonTapped:(id)sender {
    [[UIDevice currentDevice] playInputClick];
    UIButton *button = sender;
    [self.delegate numberButtonTapped:button.tag];
}

- (IBAction)deleteTapAndHold:(UILongPressGestureRecognizer *)sender {
    if (!self.deleteRepeatTimer) {
        self.deleteRepeatTimer = [NSTimer scheduledTimerWithTimeInterval:0.125 target:self selector:@selector(sendDeleteButtonPress) userInfo:nil repeats:YES];
    }
    
    if (sender.state == UIGestureRecognizerStateEnded && self.deleteRepeatTimer) {
        [self.deleteRepeatTimer invalidate];
        self.deleteRepeatTimer = nil;
    }
}

- (void)sendDeleteButtonPress {
    [[UIDevice currentDevice] playInputClick];
    [self.delegate numberButtonTapped:DBNumberPadButtonBackspace];
}

- (void)setBottomLeftButtonDot {
    self.bottomLeftButton.tag = DBNumberPadButtonDot;
    [self.bottomLeftButton setTitle:@"." forState:UIControlStateNormal];
}

- (void)setBottomLeftButton00 {
    self.bottomLeftButton.tag = DBNumberPadButton00;
    [self.bottomLeftButton setTitle:@"00" forState:UIControlStateNormal];
}

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

#pragma mark -
#pragma mark Initializers
+ (id)numberPadInputView {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"DBKitResources" ofType:@"bundle"];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:bundlePath];
    return [DBNumberPadInputView viewFromNibInBundle:resourcesBundle];
}

+ (id)sharedNumberPadInputView {
    static dispatch_once_t onceToken;
    static DBNumberPadInputView *numberPadInputView = nil;
    
    dispatch_once(&onceToken, ^{
        
        numberPadInputView = [DBNumberPadInputView numberPadInputView];
    });
    
    return numberPadInputView;
}

@end
