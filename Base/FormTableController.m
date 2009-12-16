//
//  FormTableController.m
//  MyMaps
//
//  Created by P. Mark Anderson on 12/15/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "FormTableController.h"


@implementation FormTableController
@synthesize fields;

- (void)dealloc {
  [fields release];
  [super dealloc];
}

- (void) setTextField:(UITextField*)textField value:(NSString*)newValue {
  NSLog(@"FormTableController - setTextField:value: should be implemented by a subclass");
}

- (void) selectNextTextField:(UITextField*)textField {
  NSInteger nextTag = textField.tag+1;
  UIView *nextField = [self.view viewWithTag:nextTag];

  if ([nextField isKindOfClass:[UITextField class]]) {
    UITableView *table = (UITableView*)textField.superview.superview.superview;
    NSUInteger nextRow = nextTag - [self firstTag];
    
    // if there's a row past the next row, scroll to it
    NSInteger rowCount = [table numberOfRowsInSection:[self textFieldSection]];
    if (rowCount > (nextRow+2)) {
      nextRow += 2;
    } else if (rowCount > (nextRow+1)) {
      nextRow += 1;
    }
    NSIndexPath *index = [NSIndexPath indexPathForRow:nextRow inSection:[self textFieldSection]];
        
    [table scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [nextField becomeFirstResponder];    
  } else {
    [textField endEditing:NO];
  }
}

- (NSString*) tagAsString:(UIView*)view {
	return [NSString stringWithFormat:@"%i", view.tag];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self setTextField:textField value:textField.text];
  [self selectNextTextField:textField];
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  [self setTextField:textField value:@""];
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSString *newValue;  
  if (range.length == 0) {
    // simply append
    newValue = [NSString stringWithFormat:@"%@%@", textField.text, string];
  } else {
    // delete range of characters
    NSMutableString *tmp = [NSMutableString stringWithString:textField.text];
    [tmp deleteCharactersInRange:range];
    newValue = [NSString stringWithString:tmp];
  }

  [self setTextField:textField value:newValue];
  
  return YES;
}

- (NSInteger) firstTag {
  return 0;
}

- (NSInteger) textFieldSection {
  return 0;
}

@end
