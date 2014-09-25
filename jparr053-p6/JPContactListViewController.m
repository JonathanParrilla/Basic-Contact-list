//
//  JPMasterViewController.m
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

#import "JPContactListViewController.h"

#import "JPDetailViewController.h"

#import "JPNewContactViewController.h"

#import "JPAddressBook.h"

#import "JPAddressCard.h"

@interface JPContactListViewController ()
{
    NSMutableArray *_objects;
}

@end

@implementation JPContactListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        self.title = NSLocalizedString(@"Contacts", @"Contacts");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(600.0, 600.0);
        }
        
        
        
        
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        
        self.navigationItem.leftBarButtonItem = addButton;
    }
    
    /*
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    
    self.navigationItem.leftBarButtonItem = addButton;
    
     -----
    */
    addressBook = [JPAddressBook theAddressBook];
    
    [addressBook sort2];
    
    _objects = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < [addressBook entries]; index++)
    {
        JPAddressCard *currentCard = [addressBook.book objectAtIndex:index];
        
        [_objects insertObject:currentCard.fullName atIndex:index];
    }
    
}

// Reloads the tableview so any added contacts show up
-(void) viewWillAppear:(BOOL)animated
{
    Boolean *hasBookChanged = addressBook.bookHasChanged;

    if(hasBookChanged)
    {
        
        [_objects removeAllObjects];
        
        [self.tableView reloadData];
        
    
        [addressBook sort2];
    
    
        for (int index = 0; index < [addressBook entries]; index++)
        {
            JPAddressCard *currentCard = [addressBook.book objectAtIndex:index];
        
            [_objects insertObject:currentCard.fullName atIndex:index];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];            
        }

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Adding a new contact/object
- (void)insertNewObject:(id)sender
{
    if (!_objects)
    {
        _objects = [[NSMutableArray alloc] init];
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
	    JPNewContactViewController *newContact = [[JPNewContactViewController alloc] initWithNibName:@"JPNewContactView_iPhone" bundle:nil];
        
        [self.navigationController pushViewController: newContact animated:YES];
        
    }
    
    else
    {
        
        
    }
    
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }


    NSDate *object = _objects[indexPath.row];
    
    cell.textLabel.text = [object description];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *name = _objects[indexPath.row];
        
        JPAddressCard *cardToBeDeleted = [addressBook lookup:name];
        
        [addressBook removeCard:cardToBeDeleted];
        
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *name = _objects[indexPath.row];
    
    JPAddressCard *selectedPerson = [addressBook lookup:name];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
	    if (!self.detailViewController)
        {
	        self.detailViewController = [[JPDetailViewController alloc] initWithNibName:@"JPDetailViewController_iPhone" bundle:nil];
	    }
                
        self.detailViewController.card = selectedPerson;
        
        [self.navigationController pushViewController:self.detailViewController animated:YES];
        
    }
    
    else
    {
        self.detailViewController.card = selectedPerson;
    }
}

@end
