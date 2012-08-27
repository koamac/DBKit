//
//  DBDecimalTextField.m
//  DBKit
//
//  Created by David Barry on 2/3/12.
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


#import "DBDecimalTextField.h"
#import "DBNumberFormatting.h"
#import "DBNumberPadInputView.h"

@interface DBDecimalTextField () <DBNumberPadInputDelegate>

@end

const int kDefaultMaximumNumberOfDecimalDigits = 0;

@implementation DBDecimalTextField
@synthesize decimalFormatter = _decimalFormatter;
@synthesize numberPad = _numberPad;

#pragma mark -
#pragma mark Init
- (void)setup {
    self.defaultValue = [NSDecimalNumber zero];
    self.maximumNumberOfDigits = kDefaultMaximumNumberOfDecimalDigits;
}

- (id)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (BOOL)becomeFirstResponder {
    self.numberPad.delegate = self;
    [self.numberPad setBottomLeftButtonDot];
    return [super becomeFirstResponder];
}

#pragma mark -
#pragma mark NumberPad Delegate
- (void)numberButtonTapped:(DBNumberPadButton)numberPadButton {
    //Check to see if we're at our length limit
    if (numberPadButton != DBNumberPadButtonBackspace && self.maximumNumberOfDigits > 0 && self.text.length >= self.maximumNumberOfDigits)
        return;
    
    NSString *modifiedText = self.text;
    //Accept and parse the input. This is done doing string manipulation, after the manipulation has been done we
    //convert it to a decimal number and check to see if the input is valid before applying the new text.
    if (numberPadButton < DBNumberPadButtonBackspace) {
        modifiedText = [modifiedText stringByAppendingFormat:@"%d", numberPadButton];
    } else if (numberPadButton == DBNumberPadButtonDot && [modifiedText rangeOfString:@"."].location == NSNotFound) {
        //We want to make sure we have a leading zero
        if (modifiedText.length == 0)
            modifiedText = [modifiedText stringByAppendingString:@"0"];
        
        modifiedText = [modifiedText stringByAppendingString:@"."];
    } else if (numberPadButton == DBNumberPadButtonBackspace && modifiedText.length > 0) {
        if (modifiedText.length == 1)
            modifiedText = @"";
        else 
            modifiedText = [modifiedText substringToIndex:modifiedText.length - 1];
    }
    
    //Check this value to make sure it's in the range before applying it. If it's greater than the maximum value, use the maximum value instead
    //If the value is zero, use a blank string so the placeholder string is used instead.
    NSDecimalNumber *newDecimalValue = [NSDecimalNumber decimalNumberWithString:modifiedText];
    if ([newDecimalValue isEqual:[NSDecimalNumber zero]] && [modifiedText rangeOfString:@"."].location == NSNotFound) {
        modifiedText = @"";
    } else if (self.maximumValue && [self.maximumValue compare:newDecimalValue] == NSOrderedAscending) {
        modifiedText = [self.decimalFormatter stringFromNumber:self.maximumValue];
    }
    
    self.text = modifiedText;
}

#pragma mark -
#pragma mark Accessors
- (DBNumberPadInputView *)numberPad {
    if (!_numberPad) 
        _numberPad = [DBNumberPadInputView sharedNumberPadInputView];
    
    return  _numberPad;
}

- (void)setNumberPad:(DBNumberPadInputView *)numberPad {
    _numberPad = numberPad;
    self.inputView = numberPad;
}

- (void)setDecimalValue:(NSDecimalNumber *)decimalValue {
    if ([decimalValue isEqualToNumber:[NSDecimalNumber zero]]) 
        self.text = @"";
    else
        self.text = [self.decimalFormatter stringFromNumber:decimalValue];
}

- (void)setDefaultValue:(NSDecimalNumber *)defaultValue {
    _defaultValue = defaultValue;
    self.placeholder = [self.decimalFormatter stringFromNumber:defaultValue];
}

- (NSDecimalNumber *)decimalValue {
    if (self.text && ![self.text isEqualToString:@""]) {
        return [NSDecimalNumber decimalNumberWithString:self.text];
    } else {
        return self.defaultValue;
    }
}

- (NSNumberFormatter *)decimalFormatter {
    if (!_decimalFormatter) {
        _decimalFormatter = [DBNumberFormatting sharedDecimalFormatter];
    }
    
    return _decimalFormatter;
}

- (void)setDecimalFormatter:(NSNumberFormatter *)decimalFormatter {
    _decimalFormatter = decimalFormatter;
    self.text = [self.decimalFormatter stringFromNumber:self.decimalValue];
}

#pragma mark -
#pragma mark Behavior Customization
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
