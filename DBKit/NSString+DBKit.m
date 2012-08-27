//
//  NSString+DBKit.m
//  DBKit
//
//  Created by David Barry on 8/16/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "NSString+DBKit.h"

@implementation NSString (DBKit)
- (NSString *)URLEncodedString {
    NSString *encodedString = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, CFSTR(""), CFSTR("!*'();:@&=+$,/?%#[] "), kCFStringEncodingUTF8);
    return encodedString;
}
@end
