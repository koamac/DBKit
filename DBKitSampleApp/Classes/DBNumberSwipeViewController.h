//
//  DBNumberSwipeViewController.h
//  DBKitSampleApp
//
//  Created by David Barry on 11/7/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBNumberSwipeViewController : UIViewController
@property (weak, nonatomic) IBOutlet DBNumberSwipeControl *swipeControl;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

- (IBAction)swipeControlValueChanged:(id)sender;
- (IBAction)animationStyleChanged:(id)sender;
- (IBAction)manuallyIncrement:(id)sender;
@end
