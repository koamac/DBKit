//
//  DBManagedObject.h
//  DBKit
//
//  Created by David Barry on 9/12/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface DBManagedObject : NSManagedObject
+ (NSString *)entityName;
+ (NSEntityDescription *)entityDescription;
+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context;

- (id)init;
- (id)initInContext:(NSManagedObjectContext *)context;
+ (id)newInContext:(NSManagedObjectContext *)context;
@end
