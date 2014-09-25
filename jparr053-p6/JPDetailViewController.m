//
//  JPDetailViewController.m
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

#import "JPDetailViewController.h"

#import "JPNewContactViewController.h"

#import "JPAddressBook.h"

#import "JPAddressCard.h"

#import "JPEditContactViewController.h"

@interface JPDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation JPDetailViewController


#pragma mark - Managing the detail item

// Setting a card.
- (void)setCard:(JPAddressCard *)newCard
{
    if (_card != newCard)
    {
        _card = newCard;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil)
    {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}


// Configure the view when it loads.
- (void)configureView
{
    // Update the user interface for the detail item.
    
    if(self.card)
    {
        self.nameLabel.text = self.card.fullName;
        
        self.emailLabel.text = self.card.email;
        
        self.phoneLabel.text = self.card.phone;
        
        self.addressLabel.text = self.card.address;
        
        self.contactsImage.image = self.card.photo;
        
        self.dobLabel.text = ([NSString stringWithFormat:@"%@",self.card.dob]);
        
    }    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    addressBook = [JPAddressBook theAddressBook];
    
    //UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editObject)];
    
    UIBarButtonItem *editContactButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit Contact" style:UIBarButtonItemStyleBordered target:self action:@selector (editObject)];
    
    self.navigationItem.rightBarButtonItem = editContactButton;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Contact", @"Contact");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Contacts", @"Contacts");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editObject:)];
    
    //self.navigationItem.rightBarButtonItem = addButton;

    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];
    
    
}

// Inserting a new object/contact.
- (void)insertNewObject:(id)sender
{
    JPNewContactViewController *newContact = [[JPNewContactViewController alloc] initWithNibName:@"JPNewContactView_iPad" bundle:nil];
    
    [self.navigationController pushViewController: newContact animated:YES];
    
}


// Editing an object/contact
-(void) editObject
{
    // If it's an iPhone, do the following...
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.editContactViewController = [[JPEditContactViewController alloc]initWithNibName:@"JPEditContactView_iPhone" bundle:nil];
        
        self.editContactViewController.currentContact = self.card;
        
        [self.navigationController pushViewController: self.editContactViewController animated:YES];
        
    }
    
	// Otherwise it's an iPad.
    else
    {
        self.editContactViewController = [[JPEditContactViewController alloc]initWithNibName:@"JPEditContactView_iPad" bundle:nil];
        
        self.editContactViewController.currentContact = self.card;
        
        [self.navigationController pushViewController: self.editContactViewController animated:YES];
    }
}


- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
