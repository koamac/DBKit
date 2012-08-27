//
//  NSTimer+DBKit.m
//  DBKit
//
//  Created by David Barry on 4/30/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "NSTimer+DBKit.h"

@implementation NSTimer (DBKit)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)())theBlock {
    void (^copiedBlock)() = [theBlock copy];
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(fireBlock:) userInfo:copiedBlock repeats:yesOrNo];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo block:(void (^)())theBlock {
    void (^copiedBlock)() = [theBlock copy];
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(fireBlock:) userInfo:copiedBlock repeats:yesOrNo];
}

+ (void)fireBlock:(NSTimer *)timer {
    void (^theBlock)() = timer.userInfo;
    theBlock();
}
@end
