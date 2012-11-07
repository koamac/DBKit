//
//  AppDelegate.m
//  DBKitSampleApp
//
//  Created by David Barry on 11/6/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [DBCoreData standUp];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[RootTableViewController new]];
    self.window.rootViewController = navController;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [DBCoreData saveToDisk];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
