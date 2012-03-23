//
//  DBNumberFormatting.h
//  DBNumericInput
//
//  Created by David Barry on 3/23/11.
//  Copyright (c) 2011 David Barry


#import <Foundation/Foundation.h>

@interface DBNumberFormatting : NSObject
+ (NSNumberFormatter *)sharedPriceFormatter;
+ (NSNumberFormatter *)sharedDecimalFormatter;
@end
