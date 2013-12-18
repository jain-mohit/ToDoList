//
//  ToDoComposeViewController.m
//  ToDoList
//
//  Created by Mohit Jain on 12/17/13.
//  Copyright (c) 2013 ToDoList. All rights reserved.
//

#import "ToDoComposeViewController.h"
#import "ToDoAppDelegate.h"
#import "ToDo.h"

@interface ToDoComposeViewController ()

@end

@implementation ToDoComposeViewController

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
    
    if(self.update) {
        
        self.saveButton.hidden = TRUE;
        self.updateButton.hidden = FALSE;
        
    if (self.noteDetails) {
        self.notesTextView.text = self.noteDetails;
    }
 
        if([self.complete integerValue]%2){
            [self.checkUncheckButton setImage:[UIImage imageNamed:@"checkbox_ON"] forState:UIControlStateNormal];
        }
        else {
            [self.checkUncheckButton setImage:[UIImage imageNamed:@"checkbox_OFF"] forState:UIControlStateNormal];
        }
    
    if (self.hideCancel) {
        self.cancelButton.hidden = TRUE;
    }
 }
    else {
        self.saveButton.hidden = FALSE;
        self.updateButton.hidden = TRUE;
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)checkUncheckToDo:(id)sender
{
    count++;
    
    if(count%2){
       [self.checkUncheckButton setImage:[UIImage imageNamed:@"checkbox_ON"] forState:UIControlStateNormal];
    }
    else {
         [self.checkUncheckButton setImage:[UIImage imageNamed:@"checkbox_OFF"] forState:UIControlStateNormal];
    }
}

- (IBAction)update:(id)sender
{
    ToDoAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
	
	NSManagedObjectContext* managedObjectContext = delegate.managedObjectContext;
	
    NSError *error = nil;

    ToDo * toDo = nil;
    
    //Set up to get the thing you want to update
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"ToDo" inManagedObjectContext:managedObjectContext]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"notes=%@",self.noteDetails]];
    
    //Ask for it
    toDo = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];

    
    if (error) {
        //Handle any errors
    }
    
    if (!toDo) {
        //Nothing there to update
    }
    
    //Update the object
    toDo.notes = self.notesTextView.text;
    NSNumber *num = [NSNumber numberWithInt:count%2];
    toDo.complete = num;
    
    //Save it
    error = nil;
    if (![managedObjectContext save:&error]) {
        //Handle any error with the saving of the context
    }

    [self alertView:@"Updated" messageIs:@"Note updated"];
}


- (IBAction)save:(id)sender
{
    if(![self validate]) {
        return;
    }
    
    // save here
    ToDoAppDelegate* delegate = [[UIApplication sharedApplication] delegate];
	
	NSManagedObjectContext* managedObjectContext = delegate.managedObjectContext;
	
	NSManagedObject* newToDo;
	
	newToDo = [NSEntityDescription insertNewObjectForEntityForName:@"ToDo" inManagedObjectContext:managedObjectContext];
	
    NSNumber *num = [NSNumber numberWithInt:count%2];
	[newToDo setValue:self.notesTextView.text forKey:@"notes"];
	[newToDo setValue:num forKey:@"complete"];
	
	NSError* error;
	[managedObjectContext save:&error];

    [self cancel:nil];
}

// Validate notes
- (BOOL)validate
{
    if (self.notesTextView.text == nil || [self.notesTextView.text isEqualToString:@""]) {
        [self alertView:@"Alert" messageIs:@"Empty notes: Please enter something and then save"];
        return FALSE;
    }
    
    return TRUE;
}

- (void)alertView: (NSString *)title messageIs:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
     [alert show];
    
}

@end
