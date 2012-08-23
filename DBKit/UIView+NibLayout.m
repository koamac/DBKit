//
//  UIView+NibLayout.m
//  DBKit
//
//  Created by David Barry on 1/22/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "UIView+NibLayout.h"

@implementation UIView (NibLayout)

+ (id)viewFromNib {
    UINib *nib = [UINib nibWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
    NSArray *nibArray = [nib instantiateWithOwner:nil options:nil];
    
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

@end
