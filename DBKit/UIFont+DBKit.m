//
//  UIFont+DBKit.m
//  DBKit
//
//  Created by David Barry on 4/30/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UIFont+DBKit.h"

@implementation UIFont (DBKit)
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
