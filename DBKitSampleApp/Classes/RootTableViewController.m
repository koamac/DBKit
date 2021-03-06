//
//  RootTableViewController.m
//  DBKitSampleApp
//
//  Created by David Barry on 11/6/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "RootTableViewController.h"
#import "TimestampListViewController.h"
#import "DBNumberSwipeViewController.h"
#import "TextInputViewController.h"
typedef enum {
    RootItemDBCoreData = 0,
    RootItemDBNumberSwipeControl,
    RootItemKeyboardHandling,
    RootNumberOfItems
} RootItems;

static NSString * const kCellIdentifier = @"Cell";

@interface RootTableViewController ()
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootTableViewController

- (id)init {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.title = @"Demos";
}


#pragma mark - Data Source

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    switch (indexPath.row) {
        case RootItemDBCoreData:
            title = @"DBCoreData";
            break;
        case RootItemDBNumberSwipeControl:
            title = @"DBNumberSwipeControl";
            break;
        case RootItemKeyboardHandling:
            title = @"Keyboard Handling";
            break;
        default:
            break;
    }
    
    return title;
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case RootItemDBCoreData:
            viewController = [[TimestampListViewController alloc] initWithStyle:UITableViewStylePlain];
            break;
        case RootItemDBNumberSwipeControl:
            viewController = [DBNumberSwipeViewController new];
            break;
        case RootItemKeyboardHandling:
            viewController = [TextInputViewController new];
            break;
        default:
            break;
    }
    
    return viewController;
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return RootNumberOfItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
