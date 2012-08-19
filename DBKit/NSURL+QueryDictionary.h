//
//  NSURL+QueryDictionary.h
//  AppDotNetKit
//
//  Created by David Barry on 8/19/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (QueryDictionary)
+ (NSURL *)URLWithString:(NSString *)baseURLString queryDictionary:(NSDictionary *)dictionary;
@end
