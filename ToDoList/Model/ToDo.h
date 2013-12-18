//
//  ToDo.h
//  ToDoList
//
//  Created by Mohit Jain on 12/17/13.
//  Copyright (c) 2013 ToDoList. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDo : NSManagedObject

@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * complete;


@end
