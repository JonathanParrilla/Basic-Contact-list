//
//  JPNewContactViewController.h
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

@interface JPNewContactViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    JPAddressBook *addressBook;
}

- (IBAction)addContact:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *contactFirstName;

@property (weak, nonatomic) IBOutlet UITextField *contactLastName;

@property (weak, nonatomic) IBOutlet UITextField *contactEmail;

@property (weak, nonatomic) IBOutlet UITextField *contactPhone;

@property (weak, nonatomic) IBOutlet UITextField *contactAddress;

@property (weak, nonatomic) IBOutlet UIDatePicker *contactDateOfBirth;

@property (weak, nonatomic) IBOutlet UIImageView *contactPhoto;

@property (weak, nonatomic) UIImage *contactImage;

- (IBAction)addPicture:(id)sender;

@end
