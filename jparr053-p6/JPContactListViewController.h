//
//  JPMasterViewController.h
//  jparr053-p6
//
//  Created by Jonathan Parrilla on 4/3/14.
//  Copyright (c) 2014 Jonathan Parrilla. All rights reserved.
//

/*
 
 PROGRAMMER: Jonathan Parrilla
 
 PANTHER ID: 3767284
 
 CLASS: COP 4655 MW 5:00 PM
 
 INSTRUCTOR: Steven Luis
 
 ASSIGNMENT: Program 6 - Contact List (Jparr053-p6)
 
 DUE: Wednesday 4/9/2014
 
 */

#import <UIKit/UIKit.h>

@class JPDetailViewController;

@class JPNewContactViewController;

@class JPAddressBook;

@class JPAddressCard;

@interface JPContactListViewController : UITableViewController <UISplitViewControllerDelegate>
{
    JPAddressBook *addressBook;
}

@property (strong, nonatomic) JPDetailViewController *detailViewController;

//@property (strong, nonatomic) JPNewContactViewController *newContactViewController;

@end
