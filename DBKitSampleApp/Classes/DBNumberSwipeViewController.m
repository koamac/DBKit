//
//  DBNumberSwipeViewController.m
//  DBKitSampleApp
//
//  Created by David Barry on 11/7/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "DBNumberSwipeViewController.h"

@interface DBNumberSwipeViewController ()

@end

@implementation DBNumberSwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.swipeControl.placeholderTextColor = [UIColor whiteColor];
    self.stepper.value = self.swipeControl.defaultValue;
    self.stepper.minimumValue = self.swipeControl.minimumValue;
    self.stepper.maximumValue = self.swipeControl.maximumValue;
}

- (IBAction)swipeControlValueChanged:(id)sender {
    NSLog(@"Swipe Control Value: %d", self.swipeControl.value);
    self.stepper.value = self.swipeControl.value;
}

- (IBAction)animationStyleChanged:(id)sender {
    DBAnimationStyle style = DBAnimationStyleStraight;
    
    switch ([sender selectedSegmentIndex]) {
        case 0:
            style = DBAnimationStyleLeftRadial;
            break;
        case 1:
            style = DBAnimationStyleStraight;
            break;
        case 2:
            style = DBAnimationStyleRightRadial;
            break;
        default:
            break;
    }
    
    [self.swipeControl setAnimationStyle:style];
}

- (IBAction)manuallyIncrement:(id)sender {
    UIStepper *stepper = sender;
    [self.swipeControl setValue:[stepper value] animated:YES];
}
@end
