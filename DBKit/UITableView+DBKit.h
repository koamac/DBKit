//
//  UITableView+DBKit.h
//  DBKit
//
//  Created by David Barry on 8/26/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DBKit)
- (NSIndexPath *)indexPathForCellContainingView:(UIView *)view;
@end
