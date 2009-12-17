//
//  RootViewController.m
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright Bordertown Labs, LLC 2009. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MyMapsController.h"
#import "LoginController.h"
#import "MyMaps.h"
#import "GDataEntryMap.h"
#import "MapViewController.h"

@implementation MyMapsController
@synthesize maps, myGoogleMaps, table, sm3dar;

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  if (self.sm3dar == nil) {
    SM3DAR_Controller *tmpSm3dar = [[[SM3DAR_Controller alloc] init] autorelease];
    //[self.view addSubview:controller.view];
    self.sm3dar = tmpSm3dar;	
    self.sm3dar.delegate = nil;
  }
  
  if (self.myGoogleMaps == nil) {
    [self reloadGoogleMaps];
  }
}

- (void)reloadGoogleMaps {
  MyGoogleMaps *mgm = [[MyGoogleMaps alloc] initWithUsername:KEYCHAIN_READ_STRING(PREF_USERNAME)
                                                    password:KEYCHAIN_READ_STRING(PREF_PASSWORD) 
                                                   userAgent:USER_AGENT];
  self.myGoogleMaps = mgm;
  mgm.delegate = self;
  [mgm fetchFeedOfMaps];  
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.maps count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  GDataEntryMap *map = (GDataEntryMap*)[self.maps objectAtIndex:indexPath.row];
  cell.textLabel.text = [[map title] stringValue];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  // get map ID
  GDataEntryMap *map = (GDataEntryMap*)[self.maps objectAtIndex:indexPath.row];
  NSString *mapId = [map identifier];

  // TODO: check if we've already fetched this map
  
	[self.myGoogleMaps fetchFeaturesOfMapWithIdentifier:mapId];  
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


- (void)dealloc {
  [maps release];
  [myGoogleMaps release];
  [table release];
  [sm3dar release];
  [super dealloc];
}

- (IBAction) login:(id)sender {
  LoginController *loginController = [[LoginController alloc] initWithNibName:@"LoginController" bundle:[NSBundle mainBundle]];
  loginController.delegate = self;
  [self presentModalViewController:loginController animated:YES];
}

- (void) didFetchMaps:(NSArray*)allMaps {
  NSMutableArray *tmpMaps = [NSMutableArray arrayWithCapacity:[allMaps count]];
  
  for (id wtf in allMaps) {
    //NSLog(@"map: %@", [wtf title]);
    [tmpMaps addObject:wtf];
  }

  self.maps = tmpMaps;
  NSLog(@"reloading...\n");
  [self.table reloadData];
}

- (void) loadMapViewWithPoints:(NSArray*)points { 
  NSLog(@"Loading %i points", [points count]);
  MapViewController *mapViewer = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle]];
  mapViewer.points = points;
  mapViewer.sm3dar = self.sm3dar;
  [self.navigationController pushViewController:mapViewer animated:YES];  
  [mapViewer release];  
}

- (void) didFetchFeatures:(NSArray*)features {

  // compile markers into an array of POIs

	NSMutableArray *tempLocationArray = [[NSMutableArray alloc] initWithCapacity:[features count]];
	CLLocation *tempLocation;
	CLLocationCoordinate2D location;
	SM3DAR_PointOfInterest *tempCoordinate;		
	
	NSLog(@"\n\ntitle, lat, lon, alt:");
	for (GDataEntryMapFeature *f in features) {
		GDataXMLElement *xml = [[f KMLValues] objectAtIndex:0];		
		NSString *coords = [[[xml elementsForName:@"Point"] objectAtIndex:0] stringValue];
		NSArray *chunks = [coords componentsSeparatedByString:@","];
		double lat, lng, alt;
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		lng = [[formatter numberFromString:(NSString*)[chunks objectAtIndex:0]] doubleValue];
		lat = [[formatter numberFromString:(NSString*)[chunks objectAtIndex:1]] doubleValue];
		alt = [[formatter numberFromString:(NSString*)[chunks objectAtIndex:2]] doubleValue];
		[formatter release];
		location.latitude = lat;
		location.longitude = lng;
		tempLocation = [[CLLocation alloc] initWithCoordinate:location altitude:alt horizontalAccuracy:1.0 verticalAccuracy:1.0 timestamp:[NSDate date]];

		NSString *featureName = [[[xml elementsForName:@"name"] objectAtIndex:0] stringValue];
		tempCoordinate = [[SM3DAR_PointOfInterest alloc] initWithLocation:tempLocation title:featureName subtitle:nil url:nil];

		//NSLog(@"%@,%f,%f,%f", tempCoordinate.title, lat, lng, alt);		
    /*
		[jsonArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
													featureName, @"title",
													@"", @"subtitle",
													[NSNumber numberWithDouble:lat], @"latitude",
													[NSNumber numberWithDouble:lng], @"longitude",
													[NSNumber numberWithDouble:alt], @"altitude",
													nil]];
		*/
		[tempLocationArray addObject:tempCoordinate];
		[tempLocation release];		
	}
	
	//[self.arController addCoordinates:tempLocationArray];

	// convert to json
	//NSLog(@"\nPoints of interest as JSON\n");
	//NSLog([jsonArray jsonStringValue]);
  
  [self loadMapViewWithPoints:tempLocationArray];

	[tempLocationArray release];
	//[jsonArray release];

}

- (void) loginControllerWillBeDismissed {
  [self reloadGoogleMaps];
}

@end

