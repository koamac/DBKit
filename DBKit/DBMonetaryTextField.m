//
//  DBMonetaryTextField.m
//  DBNumericInput
//
//  Created by David Barry on 1/31/12.
//  Copyright (c) 2011 David Barry


#import "DBMonetaryTextField.h"
#import "DBNumberPadInputView.h"
#import "DBNumberFormatting.h"

const int kDefaultMaximumNumberOfDigits = 0;

@interface DBMonetaryTextField () <DBNumberPadInputDelegate>
@property (nonatomic) int digitsAfterDecimal;
@end

@implementation DBMonetaryTextField
@synthesize numberPad = _numberPad;
@synthesize decimalValue = _decimalValue;
@synthesize maximumValue = _maximumValue;
@synthesize priceFormatter = _priceFormatter;
@synthesize digitsAfterDecimal = _digitsAfterDecimal;
@synthesize maximumNumberOfDigits = _maximumNumberOfDigits;

#pragma mark -
#pragma mark init
- (void)setup {
    self.decimalValue = [NSDecimalNumber zero];
    self.placeholder = [self.priceFormatter stringFromNumber:[NSDecimalNumber zero]];
    self.maximumNumberOfDigits = kDefaultMaximumNumberOfDigits;
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
    [self.numberPad setBottomLeftButton00];
    return [super becomeFirstResponder];
}

#pragma mark -
#pragma mark Number Pad Methods
- (void)numberButtonTapped:(DBNumberPadButton)numberPadButton {
    //Check for invalid input such as: the length has reached the maximum value
    //Or the entered value is zero, and we're trying to backspace or add more zeros.
    if ((numberPadButton != DBNumberPadButtonBackspace && self.maximumNumberOfDigits > 0 && self.text.length >= self.maximumNumberOfDigits) ||
        ([self.decimalValue isEqualToNumber:[NSDecimalNumber zero]] && (numberPadButton == DBNumberPadButtonBackspace || numberPadButton == DBNumberPadButton0 || numberPadButton == DBNumberPadButton00))) {
        return;
    }
    
    NSDecimalNumber *newDecimalValue = self.decimalValue;
    if (numberPadButton < DBNumberPadButtonBackspace) {
        NSDecimalNumber *numberToAdd = [NSDecimalNumber decimalNumberWithMantissa:numberPadButton exponent:-self.digitsAfterDecimal isNegative:NO];
        newDecimalValue = [newDecimalValue decimalNumberByMultiplyingByPowerOf10:1];
        newDecimalValue = [newDecimalValue decimalNumberByAdding:numberToAdd];
    } else if (numberPadButton == DBNumberPadButton00) {
        newDecimalValue = [newDecimalValue decimalNumberByMultiplyingByPowerOf10:2];
    } else if (numberPadButton == DBNumberPadButtonBackspace) {
        int lastDigit = [[self.text substringFromIndex:(self.text.length - 1)] intValue];
        NSDecimalNumber *numberToRemove = [NSDecimalNumber decimalNumberWithMantissa:lastDigit exponent:-self.digitsAfterDecimal isNegative:NO];
        newDecimalValue = [newDecimalValue decimalNumberBySubtracting:numberToRemove];
        newDecimalValue = [newDecimalValue decimalNumberByMultiplyingByPowerOf10:-1];
    }
    
    if (self.maximumValue && [self.maximumValue compare:newDecimalValue] == NSOrderedAscending)
        newDecimalValue = self.maximumValue;
    
    if (![self.decimalValue isEqualToNumber:newDecimalValue])
        self.decimalValue = newDecimalValue;
}


#pragma mark -
#pragma mark Accessors
- (DBNumberPadInputView *)numberPad {
    if (!_numberPad) 
        self.numberPad = [DBNumberPadInputView sharedNumberPadInputView];
    
    return  _numberPad;
}

- (void)setNumberPad:(DBNumberPadInputView *)numberPad {
    _numberPad = numberPad;
    self.inputView = numberPad;
}

- (void)setDecimalValue:(NSDecimalNumber *)decimalValue {
    _decimalValue = decimalValue;
    if ([decimalValue isEqualToNumber:[NSDecimalNumber zero]]) 
        self.text = @"";
    else
        self.text = [self.priceFormatter stringFromNumber:decimalValue];
}

- (NSNumberFormatter *)priceFormatter {
    if (!_priceFormatter) {
        _priceFormatter = [DBNumberFormatting sharedPriceFormatter];
        self.digitsAfterDecimal = [_priceFormatter maximumFractionDigits];
    }
    return _priceFormatter;
}

- (void)setPriceFormatter:(NSNumberFormatter *)priceFormatter {
    _priceFormatter = priceFormatter;
    self.digitsAfterDecimal = [self.priceFormatter maximumFractionDigits];
    self.text = [self.priceFormatter stringFromNumber:self.decimalValue];
}

#pragma mark -
#pragma mark Behavior Customization
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
