//
//  DBNumberSwipeControl.m
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

#import "DBNumberSwipeControl.h"

typedef enum {
    DBSwipeAnimationDirectionNone = 0,
    DBSwipeAnimationDirectionUp,
    DBSwipeAnimationDirectionDown,
    DBSwipeAnimationDirectionFade
} DBSwipeAnimationDirection;

typedef enum {
    DBValueStylePlaceholder = 0,
    DBValueStyleSelected
} DBValueStyle;

@interface DBNumberSwipeControl() 
@property (strong, nonatomic) UIView *currentValueView;
@property (assign, nonatomic) CGRect valueViewFrame;
@property (assign, nonatomic) CGPoint valueViewCenter;

- (void)setup;
- (void)refresh;

- (void)swipeUp:(UIGestureRecognizer *)gesture;
- (void)swipeDown:(UIGestureRecognizer *)gesture;
- (void)tap:(UIGestureRecognizer *)gesture;

- (void)setValue:(NSInteger)value animated:(BOOL)animated sendActions:(BOOL)sendActions;

- (void)advanceViewToCurrentValueInDirection:(DBSwipeAnimationDirection)direction;
- (void)bounceValueViewInDirection:(DBSwipeAnimationDirection)direction;
- (CGPoint)topCenterPointForCurrentChangeStyle;
- (CGPoint)bottomCenterPointForCurrentChangeStyle;

- (UIView *)valueViewForNumber:(NSInteger)number;
- (UIView *)valueViewForNumber:(NSInteger)number andStyle:(DBValueStyle)style;
@end

@implementation DBNumberSwipeControl
@synthesize textColor = _textColor;
@synthesize placeholderTextColor = _placeholderTextColor;

#pragma mark - Initializers

- (void)setDefaults {
    _defaultValue = 0;
    _minimumValue = 0;
    _maximumValue = 9;
    _value = NSNotFound;
    _animationStyle = DBAnimationStyleStraight;
    _imageNamePrefix = nil;
    self.contentMode = UIViewContentModeCenter;
    self.font = [UIFont systemFontOfSize:300.0];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaults];
        [self setup];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self setDefaults];
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setDefaults];
        [self setup];
    }
    
    return self;
}

#pragma mark - Build Up

- (void)setup {
    self.valueViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.currentValueView = [self valueViewForNumber:self.defaultValue andStyle:DBValueStylePlaceholder];
    [self addSubview:self.currentValueView];
    self.valueViewCenter = self.currentValueView.center;
    
    
    UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipeUpGesture];
    
    UISwipeGestureRecognizer *swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDownGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)refresh {
    [self setValue:self.value animated:NO];
}

#pragma mark - Gesture Recognizer Handlers

- (void)swipeUp:(UIGestureRecognizer *)gesture {
    NSInteger newValue;
    if (self.value != NSNotFound) {
        newValue = self.value + 1;
    } else {
        newValue = self.defaultValue + 1;
    }
    
    [self setValue:newValue animated:YES sendActions:YES];
}

- (void)swipeDown:(UIGestureRecognizer *)gesture {
    NSInteger newValue;
    if (self.value != NSNotFound) {
        newValue = self.value -1;
    } else {
        newValue = self.defaultValue - 1;
    }
    
    [self setValue:newValue animated:YES sendActions:YES];
}

- (void)tap:(UIGestureRecognizer *)gesture {
    if (self.value == NSNotFound) {
        [self setValue:self.defaultValue animated:YES sendActions:YES];
    }
}

#pragma mark - Accessors

- (void)setValueViewToDefaultValue {
    [self.currentValueView removeFromSuperview];
    self.currentValueView = [self valueViewForNumber:self.defaultValue andStyle:DBValueStylePlaceholder];
    [self addSubview:self.currentValueView];
}

- (void)setDefaultValue:(NSInteger)defaultValue {
    _defaultValue = defaultValue;
    
    //If a value isn't selected update the default view
    if (self.value == NSNotFound) {
        [self setValueViewToDefaultValue];
    }
}

- (void)setValue:(NSInteger)value {
    [self setValue:value animated:YES sendActions:NO];
}

- (void)setValue:(NSInteger)value animated:(BOOL)animated {
    [self setValue:value animated:animated sendActions:NO];
}

- (void)setValue:(NSInteger)value animated:(BOOL)animated sendActions:(BOOL)sendActions {
    //If we've been passed NSNotFound then reset to the default
    if (value == NSNotFound) {
        [self setValueViewToDefaultValue];
        _value = value;
        return;
    }
    
    
    if (value < self.minimumValue) {
        if (animated) [self bounceValueViewInDirection:DBSwipeAnimationDirectionDown];
        return;
        
    } else if (value > self.maximumValue) {
        if (animated) [self bounceValueViewInDirection:DBSwipeAnimationDirectionUp];
        return;
    }
    
    NSInteger oldValue = _value;
    _value = value;
    
    
    DBSwipeAnimationDirection direction;
    //This makes comparisons to determine the direction of the stroke change easier.
    if (oldValue == NSNotFound)
        oldValue = self.defaultValue;
    
    if (oldValue == value) {
        direction = DBSwipeAnimationDirectionFade;
    } else if (oldValue < value) {
        direction = DBSwipeAnimationDirectionUp;
    } else if (oldValue > value) {
        direction = DBSwipeAnimationDirectionDown;
    }
    
    if (!animated) {
        direction = DBSwipeAnimationDirectionNone;
    }
    
    [self advanceViewToCurrentValueInDirection:direction];
    if (sendActions) [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setImageNamePrefix:(NSString *)imageNamePrefix {
    _imageNamePrefix = [imageNamePrefix copy];
    [self refresh];
}

- (UIColor *)textColor {
    if (!_textColor) _textColor = [UIColor blackColor];
    
    return _textColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    if (self.value != NSNotFound) [self refresh];
}

- (UIColor *)placeholderTextColor {
    if (!_placeholderTextColor) _placeholderTextColor = [UIColor lightGrayColor];
    
    return _placeholderTextColor;
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    
    if (self.value == NSNotFound) [self refresh];
}

#pragma mark - Animation

- (void)advanceViewToCurrentValueInDirection:(DBSwipeAnimationDirection)direction {
    
    CGPoint topCenterPoint = [self topCenterPointForCurrentChangeStyle];
    CGPoint bottomCenterPoint = [self bottomCenterPointForCurrentChangeStyle];
    
    UIView *oldValueView = self.currentValueView;
    self.currentValueView = [self valueViewForNumber:self.value];
    
    UIViewAnimationCurve animationCurve;
    void (^animationBlock)(void) = nil;
    
    if (direction == DBSwipeAnimationDirectionFade) {
        self.currentValueView.alpha = 0.0;
        animationBlock = ^{
            self.currentValueView.alpha = 1.0;
            oldValueView.alpha = 0.0;
        };
        animationCurve = UIViewAnimationCurveLinear;
        
    } else if (direction == DBSwipeAnimationDirectionDown) {
        self.currentValueView.center = topCenterPoint;
        animationBlock = ^{
            self.currentValueView.center = self.valueViewCenter;
            oldValueView.center = bottomCenterPoint;
        };
        animationCurve = UIViewAnimationCurveEaseOut;
        
    } else if (direction == DBSwipeAnimationDirectionUp) {
        self.currentValueView.center = bottomCenterPoint;
        animationBlock = ^{
            self.currentValueView.center = self.valueViewCenter;
            oldValueView.center = topCenterPoint;
        };
        animationCurve = UIViewAnimationCurveEaseOut;
        
    }
    
    [self addSubview:self.currentValueView];
    
    void (^updateValueView)(BOOL) = ^(BOOL finished) {
        [oldValueView removeFromSuperview];
    };
    
    //Check to see if we setup an Animation Block.  If we didn't set one then we don't want to animate, just call the completion block.
    if (animationBlock) {
        [UIView animateWithDuration:0.25 delay:0 options:animationCurve animations:animationBlock completion:updateValueView];
    } else {
        updateValueView(YES);
    }
    
}

- (CGPoint)midPointBetweenPoint:(CGPoint)pointA andPoint:(CGPoint)pointB {
    return CGPointMake((pointA.x + pointB.x) / 2, (pointA.y + pointB.y) / 2);
}

- (void)bounceValueViewInDirection:(DBSwipeAnimationDirection)direction {
    CGPoint endPoint;
    if (direction == DBSwipeAnimationDirectionUp) {
        endPoint = [self topCenterPointForCurrentChangeStyle];
    } else if (direction == DBSwipeAnimationDirectionDown) {
        endPoint = [self bottomCenterPointForCurrentChangeStyle];
    } else {
        //We didn't get a direction of Up or Down, just return and do nothing.
        return;
    }
    
    CGPoint midPoint = [self midPointBetweenPoint:self.currentValueView.center andPoint:endPoint];
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseOut animations:^{
        self.currentValueView.center = midPoint;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            self.currentValueView.center = self.valueViewCenter;
        } completion:NULL];
    }];
}

#pragma mark - View Layout

- (CGPoint)topCenterPointForCurrentChangeStyle {
    CGPoint point = self.valueViewCenter;
    
    if (self.animationStyle == DBAnimationStyleRightRadial) {
        point.y -= self.valueViewFrame.size.height;
        point.x += self.valueViewFrame.size.width / 2;
        
    } else if (self.animationStyle == DBAnimationStyleLeftRadial) {
        point.y -= self.valueViewFrame.size.height;
        point.x -= self.valueViewFrame.size.width / 2;
        
    } else if (self.animationStyle == DBAnimationStyleStraight) {
        point.y -= self.valueViewFrame.size.height;
        
    }
    
    return point;
}

- (CGPoint)bottomCenterPointForCurrentChangeStyle {
    CGPoint point = self.valueViewCenter;
    
    if (self.animationStyle == DBAnimationStyleRightRadial) {
        point.y += self.valueViewFrame.size.height;
        point.x += self.valueViewFrame.size.width / 2;
    } else if (self.animationStyle == DBAnimationStyleLeftRadial) {
        point.y += self.valueViewFrame.size.height;
        point.x -= self.valueViewFrame.size.width / 2;
    } else if (self.animationStyle == DBAnimationStyleStraight) {
        point.y += self.valueViewFrame.size.height;
    }
    
    return point;
}

#pragma mark - Value View

- (UIView *)valueViewForNumber:(NSInteger)number {
    return [self valueViewForNumber:number andStyle:DBValueStyleSelected];
}

- (UIView *)valueViewForNumber:(NSInteger)number andStyle:(DBValueStyle)style {
    UIView *valueView;
    
    if (!self.imageNamePrefix) {
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:self.valueViewFrame];
        valueLabel.font = self.font;
        valueLabel.text = [NSString stringWithFormat:@"%d", number];
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.adjustsFontSizeToFitWidth = YES;
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        // A bit ugly for backwards compatibility with iOS5
        if ([valueLabel respondsToSelector:@selector(minimumScaleFactor)]) {
            valueLabel.minimumScaleFactor = 1/30.0;
        } else {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            valueLabel.minimumFontSize = 10.0;
            #pragma clang diagnostic pop 
        }
        
        if (style == DBValueStylePlaceholder) {
            valueLabel.textColor = self.placeholderTextColor;
        } else if (style == DBValueStyleSelected) {
            valueLabel.textColor = self.textColor;
        }
        valueView = valueLabel;
        
    } else {
        UIImageView *valueImageView = [[UIImageView alloc] initWithFrame:self.valueViewFrame];
        valueImageView.contentMode = self.contentMode;
        
        UIImage *imageToDisplay;
        
        if (style == DBValueStylePlaceholder) {
            imageToDisplay = [UIImage imageNamed:[NSString stringWithFormat:@"%@Placeholder%02d", self.imageNamePrefix, number]];
        }
        
        if (style == DBValueStyleSelected || !imageToDisplay) {
            imageToDisplay = [UIImage imageNamed:[NSString stringWithFormat:@"%@%02d", self.imageNamePrefix, number]];
        }
        
        valueImageView.image = imageToDisplay;
        
        valueView = valueImageView;
        
    }
    
    
    return valueView;
}

@end
