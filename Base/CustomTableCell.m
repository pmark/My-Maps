//
//  CustomTableCell.h
//  MyMaps
//
//  Created by Josh Aller on 12/11/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "CustomTableCell.h"

@implementation CustomTableCell 

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier {
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self initSubviews] ;
	}
	return self;
}

- (void) initSubviews {
  // this should be implemented by a subclass
}


@end
