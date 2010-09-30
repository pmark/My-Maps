//
//  RootViewController.h
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright Bordertown Labs, LLC 2009. All rights reserved.
//

#import "MyGoogleMaps.h"
#import "SM3DAR.h"
#import "LoginController.h"

@interface MyMapsController : UITableViewController <MyGoogleMapsDelegate, LoginControllerDelegate> {
  NSArray *maps;
  MyGoogleMaps *myGoogleMaps;
  IBOutlet UITableView *table;
}

@property (nonatomic, retain) NSArray *maps;
@property (nonatomic, retain) MyGoogleMaps *myGoogleMaps;
@property (nonatomic, retain) IBOutlet UITableView *table;

- (IBAction) login:(id)sender;
- (void) loadMapViewWithPoints:(NSArray*)points;
- (void)reloadGoogleMaps;

@end
