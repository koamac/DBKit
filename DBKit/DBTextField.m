//
//  DBTextField.m
//  DBKit
//
//  Created by David Barry on 8/22/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "DBTextField.h"

@implementation DBTextField

- (void)setup {
    self.textEdgeInsets = UIEdgeInsetsZero;
}

- (id)init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], self.textEdgeInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
@end
