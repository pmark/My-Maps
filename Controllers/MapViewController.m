//
//  MapView.m
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "MapViewController.h"
#import "MyMapsSession.h"

@implementation MapViewController
@synthesize sm3dar, points;

//- (void)viewDidLoad {
//  [super viewDidLoad];
//}

- (void)viewDidAppear:(BOOL)animated {
  NSLog(@"MapViewController's viewDidAppear");
  [super viewDidAppear:animated];
  
  if (self.sm3dar == nil) {
    self.sm3dar = [MyMapsSession sharedMyMapsSession].sm3dar;	    
    self.sm3dar.delegate = self;
    [self.view addSubview:self.sm3dar.view];        
    [self loadPointsOfInterest];
  }
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
  [sm3dar release];
  [points release];
  [super dealloc];
}

#pragma mark Data loading
-(void)loadPointsOfInterest {
  NSLog(@"[MyMaps] loadPointsOfInterest");
//	self.sm3dar.markerViewClass = nil;
  [self.sm3dar replaceAllPointsOfInterestWith:self.points];
  [self.sm3dar zoomMapToFit];  
  [self.sm3dar startCamera];  
}

-(void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
	//NSLog(@"POI acquired focus: %@", newPOI.title);
}

-(void)didChangeSelectionToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
	//NSLog(@"POI was selected: %@", newPOI.title);
}


@end
