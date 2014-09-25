//
//  JPNewContactViewController.m
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

#import "JPNewContactViewController.h"

#import "JPAddressBook.h"

#import "JPAddressCard.h"

#import <MobileCoreServices/MobileCoreServices.h>

@interface JPNewContactViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation JPNewContactViewController

@synthesize contactFirstName,contactLastName, contactEmail, contactPhone, contactAddress;
@synthesize contactDateOfBirth;
@synthesize contentView;
@synthesize contactImage,contactPhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Add a Contact", @"Add a Contact");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    addressBook = [JPAddressBook theAddressBook];
    
    
    
    
}

// Implementing a scroll view so users can scroll down the view.
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    
    self.scrollView.contentSize = self.contentView.bounds.size;
    
    UITapGestureRecognizer *yourTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    
    [self.scrollView addGestureRecognizer:yourTap];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Adding a contact
- (IBAction)addContact:(id)sender
{
    JPAddressCard *newContact = [[JPAddressCard alloc] init];
	
	NSDate *date = [contactDateOfBirth date];
    
    [newContact setFirstName:contactFirstName.text
                 andLastName:contactLastName.text
                    andEmail:contactEmail.text
                    andPhone:contactPhone.text
                    andAddress:contactAddress.text
					andDOB:date
                    andPicture:contactImage];
    
    [addressBook addCard:newContact];
    
    Boolean aChange = TRUE;
    
    addressBook.bookHasChanged = &(aChange);
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    textField.delegate = self;
    
    [textField resignFirstResponder];
    return YES;
}


// Adding a picture
- (IBAction)addPicture:(id)sender
{
    [self startCameraControllerFromViewController: self
                                    usingDelegate: self];
    
}


// Controlling the scrolling when a user taps the screen.
-(void)scrollTap:(UIGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}


#pragma mark - Camera Image Interface

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    // Does hardware support a camera
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    // Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    // Specify the types of camera features available
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to take pictures only.
    //cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    // Specify which object contains the picker's methods
    cameraUI.delegate = delegate;
    
    // Picker object view is attached to view hierarchy and displayed.
    [controller presentViewController: cameraUI animated: YES completion: nil ];
    return YES;
}


#pragma mark - Camera Delegate Methods

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

// For responding to the user accepting a newly-captured picture
// Picker passes a NSDictionary with acquired camera data

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    // Create an image and store the acquired picture
    
    
    contactImage = (UIImage *) [info objectForKey:
                               UIImagePickerControllerOriginalImage];
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (contactImage, nil, nil , nil);
    
    // View the image on screen
    contactPhoto.image = contactImage;
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated: YES completion:nil];
    
}

@end
