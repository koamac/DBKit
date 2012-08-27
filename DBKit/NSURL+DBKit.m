//
//  NSURL+DBKit.m
//  DBKit
//
//  Created by David Barry on 8/19/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
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

// This category was heavily inspired by a very similar category in Jonathan Wight's AppStream
// https://github.com/schwa/AppStream  Thanks to Jonathan building AppStream and open sourcing it
// I've enjoyed using and learning from it.

#import "NSURL+DBKit.h"
#import "NSString+DBKit.h"

@implementation NSURL (DBKit)
+ (NSURL *)URLWithString:(NSString *)baseURLString queryDictionary:(NSDictionary *)dictionary {
    if ([dictionary count] == 0) {
        return [NSURL URLWithString:baseURLString];
    }
    
    NSMutableArray *queryElements = [NSMutableArray array];
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *escapedKey = [key URLEncodedString];
        NSString *escapedValue = [obj URLEncodedString];
        
        [queryElements addObject:[NSString stringWithFormat:@"%@=%@", escapedKey, escapedValue]];
        
    }];
    
    NSString *URLString = [NSString stringWithFormat:@"%@?%@", baseURLString, [queryElements componentsJoinedByString:@"&"]];
    return [NSURL URLWithString:URLString];
    
}
@end
