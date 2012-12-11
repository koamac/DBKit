//
//  DBManagedObject.m
//  DBKit
//
//  Created by David Barry on 9/12/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
//

#import "DBManagedObject.h"
#import "DBCoreData.h"

@implementation DBManagedObject

+ (NSString *)entityName {
    return NSStringFromClass(self);
}

+ (NSEntityDescription *)entityDescription {
    return [self entityDescriptionInContext:[DBCoreData mainContext]];
}

+ (NSEntityDescription *)entityDescriptionInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

- (instancetype)init {
    return [self initInContext:[DBCoreData mainContext]];
}

- (instancetype)initInContext:(NSManagedObjectContext *)context {
    return [self initWithEntity:[[self class] entityDescriptionInContext:context] insertIntoManagedObjectContext:context];
}
@end
