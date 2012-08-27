//
//  NSURL+DBKit.h
//  DBKit
//
//  Created by David Barry on 8/19/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (DBKit)
+ (NSURL *)URLWithString:(NSString *)baseURLString queryDictionary:(NSDictionary *)dictionary;
@end
