//
//  MyMapsSession.m
//
//  Created by P. Mark Anderson on 5/7/09.
//  Copyright 2009 Bordertown Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyMapsSession.h"
#import "Reachability.h"
#import "SM3DAR.h"

// Matt Gallagher on 20/10/08.
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
 \
static classname *shared##classname = nil; \
 \
+ (classname *)shared##classname \
{ \
	@synchronized(self) \
	{ \
		if (shared##classname == nil) \
		{ \
			[[self alloc] init]; \
		} \
	} \
	 \
	return shared##classname; \
} \
 \
+ (id)allocWithZone:(NSZone *)zone \
{ \
	@synchronized(self) \
	{ \
		if (shared##classname == nil) \
		{ \
			shared##classname = [super allocWithZone:zone]; \
			return shared##classname; \
		} \
	} \
	 \
	return nil; \
} \
 \
- (id)copyWithZone:(NSZone *)zone \
{ \
	return self; \
} \
 \
- (id)retain \
{ \
	return self; \
} \
 \
- (NSUInteger)retainCount \
{ \
	return NSUIntegerMax; \
} \
 \
- (void)release \
{ \
} \
 \
- (id)autorelease \
{ \
	return self; \
}

@implementation MyMapsSession

SYNTHESIZE_SINGLETON_FOR_CLASS(MyMapsSession);

@synthesize networkIsReachable;

- (void)dealloc {
  [super dealloc];
}

- (void)setup {
  // init 3DAR
  [SM3DAR_Controller sharedSM3DAR_Controller];
  
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultPreferences" ofType:@"plist"]]];

	[[Reachability sharedReachability] setHostName:REACHABILITY_HOSTNAME];
  [[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
	self.networkIsReachable = YES;
  [self updateReachabilityStatus];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector( reachabilityChanged: ) name:@"kNetworkReachabilityChangedNotification" object:nil];
  
}

#pragma mark Reachability

- (void)reachabilityChanged:(NSNotification *)note {
  [self updateReachabilityStatus];
}

- (void)updateReachabilityStatus {
	NetworkStatus remoteHostStatus = [[Reachability sharedReachability] remoteHostStatus];
	NetworkStatus internetConnectionStatus = [[Reachability sharedReachability] internetConnectionStatus];
  
  // Wifi detection not used but nice to know about...
	//NetworkStatus localWiFiConnectionStatus	= [[Reachability sharedReachability] localWiFiConnectionStatus];

  self.networkIsReachable = (remoteHostStatus != NotReachable && internetConnectionStatus != NotReachable);
}

#pragma mark -
+ (NSString *)applicationDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

@end
