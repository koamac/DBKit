//
//  DBFetchedTableViewController.m
//  Define
//
//  Created by David Barry on 11/3/12.
//  Copyright (c) 2012 Soft Diesel. All rights reserved.
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

#import "DBFetchedTableViewController.h"
#import "DBCoreData.h"
#import "DBMacros.h"

@interface DBFetchedTableViewController ()
@property (assign, nonatomic) UITableViewStyle tableViewStyle;
@end

@implementation DBFetchedTableViewController

#pragma mark - Initializers

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.tableViewStyle = style;
    }
    
    return self;
}

- (id)init {
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.clearsSelectionOnViewWillAppear = YES;
        self.tableViewStyle = UITableViewStylePlain;
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.clearsSelectionOnViewWillAppear) [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView flashScrollIndicators];
}

#pragma mark - DBFetchedTableViewController

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequest]
                                                                        managedObjectContext:[self managedObjectContext]
                                                                          sectionNameKeyPath:[self sectionNameKeyPath]
                                                                                   cacheName:[self cacheName]];
        _fetchedResultsController.delegate = self;
        [_fetchedResultsController performFetch:nil];
    }
    
    return _fetchedResultsController;
}

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    fetchRequest.entity = [self entityDescription];
    fetchRequest.sortDescriptors = [self sortDescriptors];
    fetchRequest.predicate = [self predicate];
    fetchRequest.returnsObjectsAsFaults = NO;
    
    return fetchRequest;
}

- (NSPredicate *)predicate {
    return nil;
}

- (NSEntityDescription *)entityDescription {
    THROW_ABSTRACT_METHOD_EXCEPTION();
}

- (NSArray *)sortDescriptors {
    THROW_ABSTRACT_METHOD_EXCEPTION();
}

- (NSString *)sectionNameKeyPath {
    return nil;
}

- (NSString *)cacheName {
    return nil;
}

- (NSManagedObjectContext *)managedObjectContext {
    return [DBCoreData mainContext];
}

- (UITableViewRowAnimation)rowAnimationForSectionChangeType:(NSFetchedResultsChangeType)changeType atIndex:(NSUInteger)sectionIndex {
    return UITableViewRowAnimationAutomatic;
}

- (UITableViewRowAnimation)rowAnimationForRowChangeType:(NSFetchedResultsChangeType)changeType atIndexPath:(NSIndexPath *)indexPath newIndexPath:(NSIndexPath *)newIndexPath {
    return UITableViewRowAnimationAutomatic;
}

- (void)configureCell:(id)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    THROW_ABSTRACT_METHOD_EXCEPTION();
}

- (NSString *)cellReuseID {
    static NSString *reuseID = nil;
    if (!reuseID) reuseID = [NSString stringWithFormat:@"%@Cell", NSStringFromClass([self class])];
    
    return reuseID;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.frame = self.view.bounds;
        [self.view addSubview:self.tableView];
    }
    
    return _tableView;
}

#pragma mark - TableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellReuseID]];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultsController.sections[section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - NSFetchedResultsController Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    UITableViewRowAnimation rowAnimation = [self rowAnimationForSectionChangeType:type atIndex:sectionIndex];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:rowAnimation];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:rowAnimation];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableViewRowAnimation rowAnimation = [self rowAnimationForRowChangeType:type atIndexPath:indexPath newIndexPath:newIndexPath];
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:rowAnimation];
            break;
		}
			
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:rowAnimation];
            break;
		}
			
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] forRowAtIndexPath:indexPath];
            break;
		}
			
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:rowAnimation];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:rowAnimation];
            break;
		}
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
