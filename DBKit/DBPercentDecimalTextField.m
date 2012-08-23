//
//  DBPercentDecimalTextField.m
//  DBKit
//
//  Created by David Barry on 2/22/12.
//  Copyright (c) 2012 Soft Diesel. All rights reserved.
//

#import "DBPercentDecimalTextField.h"
NSString * const kPercentSymbol = @"%";

@interface DBPercentDecimalTextField () 
@property (nonatomic, strong) UILabel *percentLabel;
- (void)setRightViewToPercentCharacter;
- (CGSize)sizeOfPercentSymbolForCurrentFont;
@end

@implementation DBPercentDecimalTextField

#pragma mark -
#pragma mark Init 
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setRightViewToPercentCharacter];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setRightViewToPercentCharacter];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self setRightViewToPercentCharacter];
    }
    return self;
}

#pragma mark -
#pragma mark Setter Overrides and Setup
- (void)setText:(NSString *)text {
    [super setText:text];
    if (text && ![text isEqualToString:@""]) 
        self.percentLabel.textColor = self.textColor;
    else 
        self.percentLabel.textColor = [UIColor lightGrayColor];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    //set up the right view to match the appropriate font
    self.percentLabel.font = font;
}

- (void)setRightViewToPercentCharacter {
    CGSize labelSize = [self sizeOfPercentSymbolForCurrentFont];
    CGRect labelFrame = CGRectMake(0, 0, labelSize.width, self.frame.size.height);
    self.percentLabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.percentLabel.font = self.font;
    //The Defult text color is the placeholder text color
    self.percentLabel.textColor = [UIColor lightGrayColor];
    self.percentLabel.backgroundColor = [UIColor clearColor];
    self.percentLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    self.percentLabel.text = kPercentSymbol;
    
    self.rightView = self.percentLabel;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (CGSize)sizeOfPercentSymbolForCurrentFont {
    return [kPercentSymbol sizeWithFont:self.font];
}

@end
