//
//  TextInputViewController.m
//  DBKitSampleApp
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
//

#import "TextInputViewController.h"

@interface TextInputViewController () <UITextFieldDelegate>
@property (weak, nonatomic) UIView *currentFirstResponder;
@end

@implementation TextInputViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(320.0f, 504.0f);
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startMonitoringKeyboardEvents];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopMonitoringKeyboardEvents];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentFirstResponder = textField;
}

#pragma mark - KeyboardHandling Delegate
- (UIScrollView *)scrollViewToAutomaticallyAdjust {
    return self.scrollView;
}

- (void)keyboardDidShow:(DBKeyboardInfo *)keyboardInfo {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard)];
}

- (void)keyboardDidHide:(DBKeyboardInfo *)keyboardInfo {
    self.navigationItem.rightBarButtonItem = nil;
}
@end
