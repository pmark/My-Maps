//
//  LoginController.m
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "LoginController.h"
#import "MyMaps.h"
#import "LabeledTextFieldTableCell.h"
#import "MyMapsController.h" 

#define TAG_USERNAME 100
#define TAG_PASSWORD 101

@implementation LoginController

@synthesize currentUsername, currentPassword, delegate;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.currentUsername = KEYCHAIN_READ_STRING(PREF_USERNAME);  
  self.currentPassword = KEYCHAIN_READ_STRING(PREF_PASSWORD);
  if (self.currentPassword != nil) {
    self.currentPassword = [@"" stringByPaddingToLength:[self.currentPassword length] withString:@"●" startingAtIndex:0];
  }    
  
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
  self.currentUsername = nil;
  self.currentPassword = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //  LabeledTextFieldTableCell *cell = [self newLabeledTextFieldForTableView:tableView];
	static NSString *cellIdentifier = @"LabeledTextFieldTableCell";  
	LabeledTextFieldTableCell *cell = (LabeledTextFieldTableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[LabeledTextFieldTableCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
  }  
  
  UITextField *textField = cell.textField;
  textField.placeholder = @"Required";
  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  textField.delegate = self;
  
  if (indexPath.row == 0) {
    cell.textLabel.text = @"Username";
    textField.tag = TAG_USERNAME;
    textField.text = self.currentUsername;
    
  } else {
    cell.textLabel.text = @"Password";
    textField.secureTextEntry = YES;
    textField.tag = TAG_PASSWORD;
    textField.text = self.currentPassword;    
  }
	
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
  [currentUsername release];
  [currentPassword release];
  [super dealloc];
}

/*
- (LabeledTextFieldTableCell *)newLabeledTextFieldForTableView:(UITableView *)tableView {   
	static NSString *cellIdentifier = @"LabeledTextFieldTableCell";  
	LabeledTextFieldTableCell *cell = (LabeledTextFieldTableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[LabeledTextFieldTableCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
  }
  
  return cell;
}
*/

- (void) setTextField:(UITextField*)textField value:(NSString*)newValue {
  NSString *settingKey;  
  if (textField.tag == TAG_USERNAME) {
    settingKey = PREF_USERNAME;
    self.currentUsername = newValue;
  } else {
    settingKey = PREF_PASSWORD;
    self.currentPassword = newValue;
  }

  KEYCHAIN_SAVE_STRING(settingKey, newValue);
}

- (NSInteger) firstTag {
  return TAG_USERNAME;
}

- (NSInteger) textFieldSection {
  return 0;
}

- (IBAction) done:(id)sender {
  [self.delegate loginControllerWillBeDismissed];
  [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end

