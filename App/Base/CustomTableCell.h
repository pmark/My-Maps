//
//  CustomTableCell.h
//  MyMaps
//
//  Created by Josh Aller on 12/11/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCell : UITableViewCell {
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void) initSubviews;

@end
