//
//  ToDoMainViewController.m
//  ToDoList
//
//  Created by Mohit Jain on 12/17/13.
//  Copyright (c) 2013 ToDoList. All rights reserved.
//

#import "ToDoMainViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDoComposeViewController.h"

@interface ToDoMainViewController ()

@end

@implementation ToDoMainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)reloadTable
{
   // [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    // save here
    ToDoAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
	
	NSManagedObjectContext* managedObjectContext = delegate.managedObjectContext;
	
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"ToDo" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
	NSError *error;
    self.listArray = [managedObjectContext executeFetchRequest:request error:&error];
    [self.tableView reloadData];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[self.listArray objectAtIndex:indexPath.row] valueForKey:@"notes"];
    
    NSNumber *completed = [[self.listArray objectAtIndex:indexPath.row] valueForKey:@"complete"];
    if([completed integerValue]==1) {
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    // Configure the cell...
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"push"]) {
        int row = self.tableView.indexPathForSelectedRow.row;
        ToDoComposeViewController *toDoDetail = [[ToDoComposeViewController alloc]init];
        toDoDetail = [segue destinationViewController];
        toDoDetail.noteDetails = [[self.listArray objectAtIndex:row] valueForKey:@"notes"];
        toDoDetail.complete = [[self.listArray objectAtIndex:row] valueForKey:@"complete"];
        toDoDetail.hideCancel = YES;
        toDoDetail.update = YES;
    }
}


@end
