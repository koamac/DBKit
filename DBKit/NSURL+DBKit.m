//
//  NSURL+DBKit.m
//  DBKit
//
//  Created by David Barry on 8/19/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

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
