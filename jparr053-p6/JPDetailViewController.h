//
//  JPDetailViewController.h
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

@class JPAddressBook;

@class JPAddressCard;

@class JPNewContactViewController;

@class JPEditContactViewController;

@interface JPDetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    JPAddressBook *addressBook;
}

@property (strong, nonatomic) JPEditContactViewController *editContactViewController;

@property (strong, nonatomic) JPAddressCard *card;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *dobLabel;


@property (weak, nonatomic) IBOutlet UIImageView *contactsImage;


@end
