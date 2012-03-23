//
//  DBNumberFormatting.m
//  DBNumericInput
//
//  Created by David Barry on 3/23/11.
//  Copyright (c) 2011 David Barry


#import "DBNumberFormatting.h"


@implementation DBNumberFormatting
+ (NSNumberFormatter *)sharedPriceFormatter {
    static dispatch_once_t onceQueue;
    static NSNumberFormatter *priceFormatter = nil;
    
    dispatch_once(&onceQueue, ^{ 
        priceFormatter = [[NSNumberFormatter alloc] init];
        [priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    });
    
    return priceFormatter;
}

+ (NSNumberFormatter *)sharedDecimalFormatter {
    static dispatch_once_t onceQueue;
    static NSNumberFormatter *quantityFormatter = nil;
    
    dispatch_once(&onceQueue, ^{ 
        quantityFormatter = [[NSNumberFormatter alloc] init];
        [quantityFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [quantityFormatter setCurrencySymbol:@""];
        [quantityFormatter setMinimumFractionDigits:0];
        [quantityFormatter setMaximumFractionDigits:5];
    });
    
    return quantityFormatter;
}

@end
