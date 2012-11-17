//
//  DBCoreData.m
//  DBCoreData
//
//  Created by David Barry on 9/6/12.
//  Copyright (c) 2012 David Barry. All rights reserved.
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

#import "DBCoreData.h"

static NSManagedObjectContext *_masterContext;
static NSManagedObjectContext *_mainContext;
static NSPersistentStoreCoordinator *_persistentStoreCoordinator;
static NSManagedObjectModel *_managedObjectModel;

@interface DBCoreData ()
+ (NSManagedObjectModel *)managedObjectModel;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
+ (NSString *)modelName;
+ (NSURL*)modelURL;
+ (NSString *)persistentStoreFileName;
+ (NSURL *)persistenStoreURL;
@end

@implementation DBCoreData
+ (void)standUp {
    [self mainContext];
}

+ (void)tearDown {
    _mainContext = nil;
    _masterContext = nil;
    _persistentStoreCoordinator = nil;
    _managedObjectModel = nil;
}

#pragma mark - Managed Object Contexts
+ (NSManagedObjectContext *)masterContext {
    if (_masterContext == nil) {
        _masterContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_masterContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
    
    return _masterContext;
}

+ (NSManagedObjectContext *)mainContext {
    if (_mainContext == nil) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_mainContext setParentContext:[self masterContext]];
    }
    
    return _mainContext;
}

#pragma mark - Saving
+ (void)saveToDisk {
    [[self masterContext] performBlock:^{
        [self saveContext:[self masterContext]];
    }];
}

+ (void)saveMainContext {
    [[self mainContext] performBlockAndWait:^{
        [self saveContext:[self mainContext]];
    }];
}

+ (void)saveMainContextToDisk {
    [self saveMainContext];
    [self saveToDisk];
}

+ (void)saveContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"Error saving context: %@", context);
    }
}

#pragma mark - Core Data Stack
+ (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {;
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[self modelURL]];
    }
    
    return _managedObjectModel;
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        NSURL *storeURL = [self persistenStoreURL];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption : @(YES), NSInferMappingModelAutomaticallyOption : @(YES) };

        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:options
                                       error:&error]) {
            NSDictionary *userInfo = @{ NSUnderlyingErrorKey : error };
            NSException *exc = nil;
            NSString *reason = @"Could not create persistent store.";
            exc = [NSException exceptionWithName:NSInternalInconsistencyException
                                          reason:reason
                                        userInfo:userInfo];
            @throw exc;
        }
        _persistentStoreCoordinator = psc;
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Model and Path Info

+ (NSString *)modelName {
    return [[[NSBundle mainBundle] bundleIdentifier] pathExtension];
}

+ (NSURL*)modelURL {
    NSString *filename = [self modelName];
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"momd"];
    NSAssert1(modelPath, @"Could not locate Managed Object Model '%@.momd'", filename);
    return [NSURL fileURLWithPath:modelPath];
}

+ (NSString *)persistentStoreFileName {
    return [[self modelName] stringByAppendingPathExtension:@"sqlite"];
}

+ (NSURL *)persistenStoreURL {
    NSString *persistentStoreName = [self persistentStoreFileName];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [documentsURL URLByAppendingPathComponent:persistentStoreName];
}

@end
