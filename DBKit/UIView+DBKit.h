//
//  UIView+DBKit.h
//  DBKit
//
//  Created by David Barry on 1/22/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DBKit)
+ (id)viewFromNib;
+ (NSString *)nibName;

- (void)setAnchorPointWithoutMovingView:(CGPoint)anchorPoint;
@end
