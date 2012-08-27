//
//  DBNumberPadInputView.m
//  DBKit
//
//  Created by David Barry on 1/31/12.
//  Copyright (c) 2011 David Barry

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
#pragma mark View Loading and Singleton
+ (id)sharedNumberPadInputView {
    static dispatch_once_t onceQueue;
    static DBNumberPadInputView *numberPadInputView = nil;
    
    dispatch_once(&onceQueue, ^{ 
        numberPadInputView = [DBNumberPadInputView viewFromNib]; 
    });
    
    return numberPadInputView;
}

@end
