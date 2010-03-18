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
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {  
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

- (void)dealloc {
  [currentUsername release];
  [currentPassword release];
  [super dealloc];
}

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

