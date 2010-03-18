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

@protocol LoginControllerDelegate
- (void) loginControllerWillBeDismissed;
@end


@interface LoginController : FormTableController <UITableViewDelegate,UITableViewDataSource> {
  NSString *currentUsername;
  NSString *currentPassword;  
  id<LoginControllerDelegate> delegate;
}

@property (nonatomic, retain) NSString *currentUsername;
@property (nonatomic, retain) NSString *currentPassword;
@property (nonatomic, assign) id<LoginControllerDelegate> delegate;

//- (LabeledTextFieldTableCell *)newLabeledTextFieldForTableView:(UITableView *)tableView;
- (IBAction) done:(id)sender;

@end
