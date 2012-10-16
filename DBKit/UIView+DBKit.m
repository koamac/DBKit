//
//  UIView+DBKit.m
//  DBKit
//
//  Created by David Barry on 1/22/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIView+DBKit.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (DBKit)

#pragma mark - Nib Loading
+ (id)viewFromNib {
    return [self viewFromNibInBundle:nil];
}

+ (id)viewFromNibInBundle:(NSBundle *)bundle {
    UINib *nib = [UINib nibWithNibName:[self _nibName] bundle:bundle];
    NSArray *nibArray = [nib instantiateWithOwner:nil options:nil];
    
    NSAssert2(([nibArray count] > 0) && [[nibArray objectAtIndex:0] isKindOfClass:[self class]],
              @"Nib '%@' does not appear to contain a valid %@", [self _nibName], NSStringFromClass([self class]));
    
    id view = nil;
    
    for (id object in nibArray) {
        if ([object isKindOfClass:[self class]]) {
            view = object;
            break;
        }
    }
    
    return view;
}

+ (NSString *)_nibName {
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
