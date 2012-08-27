//
//  UITableView+DBKit.m
//  DBKit
//
//  Created by David Barry on 8/26/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UITableView+DBKit.h"

@implementation UITableView (DBKit)
- (NSIndexPath *)indexPathForCellContainingView:(UIView *)view {
    CGPoint correctedOrigin = [view convertPoint:view.frame.origin toView:self];
    return [self indexPathForRowAtPoint:correctedOrigin];
}
@end
