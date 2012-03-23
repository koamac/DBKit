//
//  DBMonetaryTextField.h
//  DBNumericInput
//
//  Created by David Barry on 1/31/12.
//  Copyright (c) 2011 David Barry


#import <UIKit/UIKit.h>
@class DBNumberPadInputView;

@interface DBMonetaryTextField : UITextField
@property (nonatomic, strong) DBNumberPadInputView *numberPad;
@property (nonatomic, strong) NSDecimalNumber *decimalValue;
@property (nonatomic, strong) NSDecimalNumber *maximumValue;
@property (nonatomic, strong) NSNumberFormatter *priceFormatter;
@property (nonatomic) int maximumNumberOfDigits;
@end
