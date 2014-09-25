//
//  JPAddressCard.m
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

#import "JPAddressCard.h"

@implementation JPAddressCard
@synthesize name, email, firstName, lastName, phone, fullName, address;

// This method is the ultimate variable method.
// It accepts all the data relevent to a card and sets it.
-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
            andAddress: (NSString *) theAddress
            andDOB:(NSDate *)theDob
            andPicture:(UIImage *)theImage
{
    self.firstName = theFirstName;
    self.lastName = theLastName;
    self.email = theEmail;
    self.phone = thePhone;
    self.address = theAddress;
    self.dob = theDob;
    self.photo = theImage;
    
    self.name = theLastName;
    
    self.fullName = [NSString stringWithFormat:@"%@ %@",theFirstName, theLastName];
    
    
}
// This is the default card data set method. I used this ONLY for the initial 10 contacts.
-(void) setFirstName: (NSString *) theFirstName
         andLastName: (NSString *) theLastName
            andEmail: (NSString *) theEmail
            andPhone: (NSString *) thePhone
          andAddress: (NSString *) theAddress
{
    self.firstName = theFirstName;
    self.lastName = theLastName;
    self.email = theEmail;
    self.phone = thePhone;
    self.address = theAddress;
    
    self.name = theLastName;
    
    self.fullName = [NSString stringWithFormat:@"%@ %@",theFirstName, theLastName];
    
    
}


// This method was used to load the data from the plist names
-(void) assignFullName:(NSString *) theFullName andFirstName: (NSString *)theFirstName andLastName: (NSString*) theLastName
{
    self.fullName = theFullName;
    self.firstName = theFirstName;
    self.lastName = theLastName;
    
    
    //set name for sorting perposes
    self.name = theLastName;
}


-(void) setName: (NSString *) theName andEmail: (NSString *) theEmail
{
    self.name = theName;
    self.email = theEmail;
}
// Compare the two names from the specified address cards
-( NSComparisonResult) compareNames: (id) element
{
    return [name compare: [element name]];
}

-(void) print
{
    NSLog (@" ====================================");
    NSLog (@" |                                  |");
    NSLog (@" | %-31s |", [name UTF8String]);
    NSLog (@" | %-31s |", [email UTF8String]);
    NSLog (@" | |");
    NSLog (@" | |");
    NSLog (@" | |");
    NSLog (@" | O O |");
    NSLog (@" ====================================");
}

-(id) copyWithZone: (NSZone *) zone
{
    id newCard = [[[ self class] allocWithZone: zone] init];
    
    [newCard assignName: name andEmail: email];
    
    return newCard;
}

-(void) assignName: (NSString *) theName andEmail: (NSString *) theEmail
{
    name = theName;
    email = theEmail;
}

-(void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject: name forKey: @" AddressCardName"];
    [encoder encodeObject: email forKey: @" AddressCardEmail"];
}

-(id) initWithCoder: (NSCoder *) decoder
{
    name = [decoder decodeObjectForKey: @" AddressCardName"];
    email = [decoder decodeObjectForKey: @" AddressCardEmail"];
    
    return self;
}

@end

