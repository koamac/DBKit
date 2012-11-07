//
//  NumericInputViewController.m
//  DBKitSampleApp
//
//  Created by David Barry on 11/6/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "NumericInputViewController.h"

@interface NumericInputViewController ()

@end

@implementation NumericInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:NO];
}
@end
