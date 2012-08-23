//
//  DBDecimalTextField.h
//  DBNumericInput
//
//  Created by David Barry on 2/3/12.
//  Copyright (c) 2011 David Barry


#import <UIKit/UIKit.h>
#import "DBTextField.h"
@class DBNumberPadInputView;

@interface DBDecimalTextField : DBTextField
@property (nonatomic, strong) DBNumberPadInputView *numberPad;
@property (nonatomic) NSDecimalNumber *decimalValue;
@property (nonatomic, strong) NSNumberFormatter *decimalFormatter;

//This value will be used when no other value has been set. The default for this is zero
@property (nonatomic, strong) NSDecimalNumber *defaultValue;
@property (nonatomic, strong) NSDecimalNumber *maximumValue;
@property (nonatomic) int maximumNumberOfDigits;
@end
