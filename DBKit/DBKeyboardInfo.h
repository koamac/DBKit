//
//  DBKeyboardInfo.h
//  DBKitSampleApp
//
//  Created by David Barry on 3/9/13.
//  Copyright (c) 2013 David Barry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBKeyboardInfo : NSObject
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
