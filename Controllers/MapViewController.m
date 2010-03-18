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
@synthesize points;

- (void)viewDidLoad {
  [super viewDidLoad];

  // set up 3DAR
  SM3DAR_Controller *sm3dar = [SM3DAR_Controller sharedSM3DAR_Controller];
  sm3dar.delegate = self;
  sm3dar.view.backgroundColor = [UIColor blackColor];
  [self.view addSubview:sm3dar.view];
  
  // Normally 3DAR calls loadPointsOfInterest for us
  // but in this case the session has already initialized 3DAR.
  [self loadPointsOfInterest];  
}

- (void)viewDidDisappear:(BOOL)animated {
  NSLog(@"[MVC] viewDidDisappear");
  [super viewDidDisappear:animated];
  SM3DAR_Controller *sm3dar = [SM3DAR_Controller sharedSM3DAR_Controller];
  [sm3dar suspend];
//  [sm3dar stopCamera];  
}

- (void)viewDidAppear:(BOOL)animated {
  NSLog(@"MapViewController's viewDidAppear");
  [super viewDidAppear:animated];
  
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
  NSLog(@"[MVC] viewDidUnload");
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
  [points release];
  [super dealloc];
}

#pragma mark Data loading
-(void)loadPointsOfInterest {
  NSLog(@"[MyMaps] loadPointsOfInterest");

  SM3DAR_Controller *sm3dar = [SM3DAR_Controller sharedSM3DAR_Controller];
  if (!sm3dar.originInitialized) {
    NSLog(@"Warning: 3DAR is not initalized yet");
    [self performSelector:@selector(loadPointsOfInterest) withObject:nil afterDelay:2.0f];
    return;
  }

//	sm3dar.markerViewClass = nil;
  [sm3dar replaceAllPointsOfInterestWith:self.points];
  [sm3dar zoomMapToFit];
  [sm3dar resume];
//  [sm3dar startCamera];  
  [SM3DAR_Controller printMemoryUsage:@"MB after loading points of interest"];
}

-(void)didChangeFocusToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
	NSLog(@"POI acquired focus: %@", newPOI.title);
}

-(void)didChangeSelectionToPOI:(SM3DAR_PointOfInterest*)newPOI fromPOI:(SM3DAR_PointOfInterest*)oldPOI {
	//NSLog(@"POI was selected: %@", newPOI.title);
}


@end
