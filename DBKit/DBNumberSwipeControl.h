//
//  DBNumberSwipeControl.h
//  DBKit
//
//  Created by David Barry on 12/3/11.
//  Copyright (c) 2011 David Barry. All rights reserved.
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

#import <UIKit/UIKit.h>

typedef enum {
    DBAnimationStyleRightRadial = 0,
    DBAnimationStyleLeftRadial,
    DBAnimationStyleStraight
} DBAnimationStyle;

@interface DBNumberSwipeControl : UIControl
@property (assign, nonatomic) NSInteger minimumValue;
@property (assign, nonatomic) NSInteger maximumValue;
@property (assign, nonatomic) NSInteger value; //Default: NSNotFound
@property (assign, nonatomic) NSInteger defaultValue;
@property (assign, nonatomic) DBAnimationStyle animationStyle;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *placeholderTextColor;

//This property allows you to easily use images in place of plain text numbers to display
//the current value. The numbers are exptected to be in the format <prefix><XX> where <prefix>
//Is the string set for this property and <XX> is the current value. Only works for positive values
//And will fail silently and display a blank image if no image is found
//You can optionally provide images for the default(unselected) state of the control.
//These are expected to be in the format <prefix>Placeholder<XX>
@property (copy, nonatomic) NSString *imageNamePrefix;

- (void)setValue:(NSInteger)value animated:(BOOL)animated;
@end
