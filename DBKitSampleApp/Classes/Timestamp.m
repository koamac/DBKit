//
//  Timestamp.m
//  DBKitSampleApp
//
//  Created by David Barry on 11/6/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "Timestamp.h"


@implementation Timestamp
@dynamic date;

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.date = [NSDate date];
}

@end
