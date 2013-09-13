//
//  DBKeyboardInfo.h
//  DBKit
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
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

#import <Foundation/Foundation.h>

@interface DBKeyboardInfo : NSObject
@property (readonly, nonatomic) UIViewAnimationOptions animationOptions;
@property (readonly, nonatomic) UIViewAnimationCurve animationCurve;
@property (readonly, nonatomic) CGFloat animationDuration;

//These properties have all been converted to the receiving view controller's view
@property (readonly, nonatomic) CGSize size;
@property (readonly, nonatomic) CGRect beginningFrame;
@property (readonly, nonatomic) CGRect endFrame;

//Properties that begin with raw have not been converted to the current view
@property (readonly, nonatomic) CGSize rawSize;
@property (readonly, nonatomic) CGRect rawBeginningFrame;
@property (readonly, nonatomic) CGRect rawEndFrame;

+ (DBKeyboardInfo *)keyboardInfoWithNotificationDictionary:(NSDictionary *)dictionary forViewController:(UIViewController *)viewController;
@end
