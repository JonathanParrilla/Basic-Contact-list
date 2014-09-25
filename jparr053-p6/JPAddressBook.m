//
//  JPAddressBook.m
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

#import "JPAddressBook.h"
#import "JPAddressCard.h"

@implementation JPAddressBook

@synthesize book, bookName, newlyAddedContact;
@synthesize bookHasChanged;

// Global variables

// Indexes to keep track of the cards.
int indexNumber = 0;
int previousIndexNumber = 0;
bool firstTimeRunning = true;

// set up the AddressBook’s name and an empty book

-(id) initWithName: (NSString *) name
{
    self = [super init];
    
    if (self)
    {
        bookName = [NSString stringWithString: name];
        
        book = [NSMutableArray array];
        
		// The 4 default, old cards and set their data.
        JPAddressCard *card1 = [[JPAddressCard alloc] init];
        JPAddressCard *card2 = [[JPAddressCard alloc] init];
        JPAddressCard *card3 = [[JPAddressCard alloc] init];
        JPAddressCard *card4 = [[JPAddressCard alloc] init];
        
        [card1 setFirstName:@"Julia" andLastName:@"Kochan" andEmail:@"jewls337@axlc.com" andPhone:@"555-555-5555" andAddress:@"Not Available"];
        
        [card2 setFirstName:@"Tony" andLastName:@"Iannino" andEmail:@"tony.iannino@techfitness.com" andPhone:@"444-444-4444" andAddress:@"Not Available"];
        
        [card3 setFirstName:@"Steven" andLastName:@"Kochan" andEmail:@"steve@classroomM.com" andPhone:@"222-222-2222" andAddress:@"Not Available"];
        
        [card4 setFirstName:@"Jonathan" andLastName:@"Parrilla" andEmail:@"jparr053@fiu.edu" andPhone:@"305-582-3112" andAddress:@"10637 Hammocks Blvd. #918 Miami,FL 33196"];
        
        
		// Add the 4 contacts to the address book.
        [book addObject:card1];
        [book addObject:card2];
        [book addObject:card3];
        [book addObject:card4];
        
        /*
         NSString *path = [[NSBundle mainBundle] pathForResource:@"InitialContacts"
         ofType:@"plist"];
         
         NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:path];
         
         // Now add the plist full names
         // The pList cards
         for(int x = 0; x < [tempArray count]; x++)
         {
         JPAddressCard *tempCard = [[JPAddressCard alloc] init];
         
         [tempCard setFullName:[tempArray objectAtIndex:x]];
         
         [book addObject:tempCard];
         
         }
         */
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"defaultContacts"
                                                         ofType:@"plist"];
        
        NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSArray *temp = [tempDict allKeys];
        
        for(int x = 0; x < [temp count]; x++)
        {
            
            JPAddressCard *tempcard = [[JPAddressCard alloc] init];
            
            NSString *fullName = [temp objectAtIndex:x];
            
            
            NSArray *info = [tempDict objectForKey:fullName];
            
            NSString *firstName = [info objectAtIndex:0];
            
            NSString *lastName = [info objectAtIndex:1];
            
            [tempcard assignFullName:fullName andFirstName:firstName andLastName:lastName];
            
            [book addObject:tempcard];
        }
        
    }
    
    return self;
}

-(id) init
{
    return [self initWithName: @" Unnamed Book"];
}

// Write our own book setter to create a mutable copy

-(void) setBook: (NSArray *) theBook
{
    book = [theBook mutableCopy];
}

-(void) sort
{
    [book sortUsingSelector: @selector( compareNames:)];
}

// Alternate sort using blocks
-(void) sort2
{
    [book sortUsingComparator: ^( id obj1, id obj2)
     {
         return [[ obj1 lastName] compare: [obj2 lastName]];
     }];
}

-(void) addCard: (JPAddressCard *) theCard
{
    [book addObject: theCard];
    
    newlyAddedContact = theCard;
}

-(void) removeCard: (JPAddressCard *) theCard
{
    [book removeObjectIdenticalTo: theCard];
}

-(NSUInteger) entries
{
    return [book count];
}

// Method to select the next card
-( JPAddressCard *) getNextCard
{
    if(firstTimeRunning == true)
    {
        // Fill a JPAddressCard with the indexNumber equivalent in the address Book.
        JPAddressCard *theNextCard = [book objectAtIndex:indexNumber];
        
        // Assign the current indexNumber to the previousIndexNumber
        previousIndexNumber = indexNumber;
        
        // Appreciate the current indexNumber by 1.
        indexNumber++;
        
        firstTimeRunning = false;
        
        return theNextCard;
    }
    
    else
    {
        // If the current indexNumber is equal to the previousIndexNumber, then appreciate the current indexNumber by 1.
        if(indexNumber == previousIndexNumber)
        {
            indexNumber++;
        }
    
        // If the current indexNumber is equal to the total number of address cards, reset the indexNumber.
        if(indexNumber == [book count])
        {
            indexNumber = 0;
        }
    
        // Fill a JPAddressCard with the indexNumber equivalent in the address Book.
        JPAddressCard *theNextCard = [book objectAtIndex:indexNumber];
    
        // Assign the current indexNumber to the previousIndexNumber
        previousIndexNumber = indexNumber;
    
        // Appreciate the current indexNumber by 1.
        indexNumber++;
    
        return theNextCard;
    }
    
}

// Method to select the previous card
-( JPAddressCard *) getPreviousCard
{
    // Depreciate the indexNumber by 1.
    indexNumber--;
    
    // If the current indexNumber is equal to the previousIndexNumber, depreciate the current indexNumber by 1.
    if(indexNumber == previousIndexNumber)
    {
        indexNumber--;
    }
    
    //If it is less than 0, adjust the indexCounter to the last item in the Address Book.
    if(indexNumber < 0)
    {
        indexNumber = ([book count] - 1);
    }
    
    //Fill a JPAddress Card with the indexNumber equivalent inside the Address Book.
    JPAddressCard *thePreviousCard = [book objectAtIndex:indexNumber];
    
    // Assign the current indexNumber to the previousIndexNumber.
    previousIndexNumber = indexNumber;
    
    return thePreviousCard;
    
}

// Method to reset the index number.
-(void)resetIndexNumber
{
    indexNumber = 0;
    firstTimeRunning = true;
}


-( void) list
{
    NSLog (@"======== Contents of: %@ =========", bookName);
    
    for ( JPAddressCard *theCard in book )
        NSLog (@"%-20s %-32s",[theCard.name UTF8String], [theCard.email UTF8String]);
    
    NSLog (@"==================================================");
}

// lookup address card by name — assumes an exact match

-( JPAddressCard *) lookup: (NSString *) theName
{
    for ( JPAddressCard *nextCard in book )
        if ( [[ nextCard fullName] caseInsensitiveCompare: theName] == NSOrderedSame )
            return nextCard;
    
    return nil;
}

-( void) encodeWithCoder: (NSCoder *) encoder
{
    [encoder encodeObject:bookName forKey: @" AddressBookBookName"];
    [encoder encodeObject:book forKey: @" AddressBookBook"];
}

-( id) initWithCoder: (NSCoder *) decoder
{
    bookName = [decoder decodeObjectForKey: @" AddressBookBookName"];
    book = [decoder decodeObjectForKey: @" AddressBookBook"];
    
    return self;
}

// Method for NSCopying protocol
-( id) copyWithZone: (NSZone *) zone
{
    id newBook = [[[ self class] allocWithZone: zone] init];
    
    [newBook setBookName: bookName];
    
    // The following will do a shallow copy of the address book
    
    [newBook setBook: book];
    
    return newBook;
}


// Class Method that makes it into a singleton.

+(JPAddressBook *) theAddressBook
{
    static JPAddressBook *addressBook = nil;
    
    @synchronized(self)
    {
        if(!addressBook)
        {
            addressBook = [[JPAddressBook alloc] initWithName:@"My Address Book"];
        }
    }
    
    return addressBook;
}





@end

