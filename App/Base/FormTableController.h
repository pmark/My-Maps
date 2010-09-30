//
//  FormTableController.h
//  MyMaps
//
//  Created by P. Mark Anderson on 12/15/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FormTableController : UIViewController <UITextFieldDelegate> {
  NSMutableDictionary *fields;
}

@property (nonatomic, retain) NSMutableDictionary *fields;

- (NSInteger) firstTag;
- (NSInteger) textFieldSection;
- (void) setTextField:(UITextField*)textField value:(NSString*)newValue;
- (void) selectNextTextField:(UITextField*)textField;
- (NSString*) tagAsString:(UIView*)view;

@end
