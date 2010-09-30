//
//  LabeledTextFieldTableCell.h
//  MyMaps
//
//  Created by P. Mark Anderson on 12/12/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableCell.h"

@interface LabeledTextFieldTableCell : CustomTableCell {
  UITextField *textField;
}

@property (nonatomic, retain) UITextField *textField;

@end
