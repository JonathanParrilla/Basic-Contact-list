//
//  JPAddressCard.h
//  jparr053-p4
//
//  Created by Jonathan Parrilla on 2/16/14.
//  Copyright (c) 2014 Jonathan Parrilla. All rights reserved.
//

/*
 
 PROGRAMMER: Jonathan Parrilla
 
 PANTHER ID: 3767284
 
 CLASS: COP 4655 MW 5:00 PM
 
 INSTRUCTOR: Steven Luis
 
 ASSIGNMENT: Program 4 - Address Book (Jparr053-p4)
 
 MODIFIED: Program 6 - Contact List (Jparr053-p6)
 
 DUE: Wednesday 4/9/2014
 
 */


#import <Foundation/Foundation.h>

@interface JPAddressCard : NSObject

< NSCopying, NSCoding >

@property (nonatomic, copy) NSString *name, *email, *firstName, *lastName, *phone, *fullName, *address;
@property (nonatomic, strong) NSDate *dob;
@property (nonatomic, strong) UIImage *photo;

-( void) setName: (NSString *) theName andEmail: (NSString *) theEmail;
-( void) assignName: (NSString *) theName andEmail: (NSString *) theEmail;

// Create two methods to accept contact data. One for the default people from Assignment 4,
// and another for those that are to be added for assignment 6.

-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
            andAddress: (NSString *) theAddress
            andDOB: (NSDate *) theDob
            andPicture: (UIImage *) theImage;

-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
          andAddress: (NSString *) theAddress;

// And then create one for the plist data
-(void) assignFullName:(NSString *) theFullName
          andFirstName: (NSString *)theFirstName
           andLastName: (NSString*) theLastName;

-( NSComparisonResult) compareNames: (id) element;

-( void) print;

@end
