//
//  RootViewController.h
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright Bordertown Labs, LLC 2009. All rights reserved.
//

#import "MyGoogleMaps.h"

@interface MyMapsController : UITableViewController <MyGoogleMapsDelegate> {
  NSArray *maps;
  MyGoogleMaps *myGoogleMaps;
}

@property (nonatomic, retain) NSArray *maps;
@property (nonatomic, retain) MyGoogleMaps *myGoogleMaps;

- (IBAction) login:(id)sender;
- (void) loadMapView;

@end
