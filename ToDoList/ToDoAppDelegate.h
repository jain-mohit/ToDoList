//
//  ToDoAppDelegate.h
//  ToDoList
//
//  Created by Mohit Jain on 12/17/13.
//  Copyright (c) 2013 ToDoList. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
