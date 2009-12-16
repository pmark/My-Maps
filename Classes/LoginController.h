//
//  LoginController.h
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormTableController.h"
#import "LabeledTextFieldTableCell.h"

@interface LoginController : FormTableController <UITableViewDelegate,UITableViewDataSource> {
  NSString *currentUsername;
  NSString *currentPassword;  
}

@property (nonatomic, retain) NSString *currentUsername;
@property (nonatomic, retain) NSString *currentPassword;

- (LabeledTextFieldTableCell *)newLabeledTextFieldForTableView:(UITableView *)tableView;
- (IBAction) done:(id)sender;

@end
