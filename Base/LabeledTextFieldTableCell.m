//
//  LabeledTextFieldTableCell.m
//  MyMaps
//
//  Created by P. Mark Anderson on 12/12/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "LabeledTextFieldTableCell.h"


@implementation LabeledTextFieldTableCell
@synthesize textField;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
		[self initSubviews];
	}
	return self;
}

- (void) initSubviews {
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.textField = [[UITextField alloc] init]; 
  self.textField.adjustsFontSizeToFitWidth = YES;
  self.textField.minimumFontSize = 8; 
  [self.contentView addSubview:self.textField];		
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGFloat cellHeight = self.contentView.bounds.size.height;
	CGFloat fieldHeight = cellHeight;
  self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.textField.frame = CGRectMake(100, (cellHeight - fieldHeight) / 2, 195, fieldHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {  
  [super setSelected:selected animated:animated];  
  // Configure the view for the selected state
}

- (void)dealloc {
  [textField release];
  [super dealloc];
}


@end
