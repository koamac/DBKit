//
//  DBPercentDecimalTextField.m
//  DBKit
//
//  Created by David Barry on 2/22/12.
//  Copyright (c) 2012 Soft Diesel. All rights reserved.
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
