//
//  UIView+DBKitAdditions.m
//  DBKit
//
//  Created by David Barry on 1/26/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UIView+DBKitAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (DBKitAdditions)
- (void)setAnchorPointWithoutMovingView:(CGPoint)anchorPoint {
    CGPoint newPoint = CGPointMake(self.bounds.size.width * anchorPoint.x, self.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(self.bounds.size.width * self.layer.anchorPoint.x, self.bounds.size.height * self.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint position = self.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    self.layer.position = position;
    self.layer.anchorPoint = anchorPoint;
}
@end
