//
//  UIView+DBKit.m
//  DBKit
//
//  Created by David Barry on 1/22/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UIView+DBKit.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (DBKit)

#pragma mark - Nib Loading
+ (id)viewFromNib {
    UINib *nib = [UINib nibWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
    NSArray *nibArray = [nib instantiateWithOwner:nil options:nil];
    
    NSAssert2(([nibArray count] > 0) && [[nibArray objectAtIndex:0] isKindOfClass:[self class]],
              @"Nib '%@' does not appear to contain a valid %@", [self nibName], NSStringFromClass([self class]));
    
    id view = nil;
    
    for (id object in nibArray) {
        if ([object isKindOfClass:[self class]]) {
            view = object;
            break;
        }
    }
    
    return view;
}

+ (NSString *)nibName {
    return NSStringFromClass([self class]);
}

#pragma mark - View Positioning
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
