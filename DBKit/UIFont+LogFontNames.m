//
//  UIFont+LogFontNames.m
//  DBKit
//
//  Created by David Barry on 4/30/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UIFont+LogFontNames.h"

@implementation UIFont (LogFontNames)
+ (void)logAllFontNames {
    for (NSString *familyName in [self familyNames]) {
        [self logFontNamesForFamily:familyName];
    }
}

+ (void)logFontNamesForFamily:(NSString *)family {
    for (NSString *fontName in [self fontNamesForFamilyName:family]) {
        NSLog(@"%@", fontName);
    }
}
@end
