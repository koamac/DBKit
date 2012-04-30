//
//  UIFont+LogFontNames.h
//  DBKit
//
//  Created by David Barry on 4/30/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (LogFontNames)
+ (void)logAllFontNames;
+ (void)logFontNamesForFamily:(NSString *)family;
@end
