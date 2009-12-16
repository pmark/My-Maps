//
//  MyMapsAppDelegate.m
//  MyMaps
//
//  Created by P. Mark Anderson on 12/16/09.
//  Copyright Bordertown Labs, LLC 2009. All rights reserved.
//

#import "MyMapsAppDelegate.h"
#import "RootViewController.h"


@implementation MyMapsAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

