//
//  DBFetchedTableViewController.h
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

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DBFetchedTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (assign, nonatomic) BOOL clearsSelectionOnViewWillAppear;

//Required
- (NSEntityDescription *)entityDescription;
- (NSArray *)sortDescriptors;
- (void)configureCell:(id)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

//Optional
- (NSFetchRequest *)fetchRequest;
- (NSPredicate *)predicate;
- (NSString *)sectionNameKeyPath;
- (NSString *)cacheName;
- (NSManagedObjectContext *)managedObjectContext;

- (UITableViewRowAnimation)rowAnimationForSectionChangeType:(NSFetchedResultsChangeType)changeType atIndex:(NSUInteger)sectionIndex;
- (UITableViewRowAnimation)rowAnimationForRowChangeType:(NSFetchedResultsChangeType)changeType atIndexPath:(NSIndexPath *)indexPath newIndexPath:(NSIndexPath *)newIndexPath;

- (id)initWithStyle:(UITableViewStyle)style;
- (NSString *)cellReuseID;
@end
