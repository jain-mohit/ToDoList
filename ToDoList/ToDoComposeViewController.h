//
//  ToDoComposeViewController.h
//  ToDoList
//
//  Created by Mohit Jain on 12/17/13.
//  Copyright (c) 2013 ToDoList. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoComposeViewController : UIViewController {
    int count;
}

@property(nonatomic,strong)IBOutlet UILabel *completeLabel;
@property(nonatomic,strong)IBOutlet UIButton *saveButton;
@property(nonatomic,strong)IBOutlet UIButton *cancelButton;
@property(nonatomic,strong)IBOutlet UIButton *checkUncheckButton;
@property(nonatomic,strong)IBOutlet UITextView *notesTextView;
@property(nonatomic,strong)NSNumber *complete;
@property(nonatomic,assign)BOOL hideCancel;
@property(nonatomic,strong)NSString *noteDetails;
@property(nonatomic,assign)BOOL update;
@property(nonatomic,strong)IBOutlet UIButton *updateButton;



- (IBAction)cancel:(id)sender;
- (IBAction)checkUncheckToDo:(id)sender;
- (IBAction)save:(id)sender;

@end
