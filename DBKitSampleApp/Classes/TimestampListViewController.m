//
//  TimestampListViewController.m
//  DBKitSampleApp
//
//  Created by David Barry on 11/6/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "TimestampListViewController.h"
#import "Timestamp.h"

@interface TimestampListViewController ()
- (void)addTimestamp:(id)sender;
@end

@implementation TimestampListViewController

#pragma mark - UIViewController

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
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[self cellReuseID]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTimestamp:)];
}

- (void)addTimestamp:(id)sender {
    [Timestamp new];
    [DBCoreData saveMainContext];
}

#pragma mark - DBFetchedTableViewController

- (NSEntityDescription *)entityDescription {
    return [Timestamp entityDescription];
}

- (NSArray *)sortDescriptors {
    return @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
}

- (void)configureCell:(id)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *theCell = cell;
    Timestamp *timestamp = [self.fetchedResultsController objectAtIndexPath:indexPath];
    theCell.textLabel.text = [timestamp.date description];
}

@end
