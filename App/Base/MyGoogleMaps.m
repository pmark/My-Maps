//
//  MyGoogleMaps.m
//  CoffeeCommuter
//
//  Created by P. Mark Anderson on 10/12/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//

#import "MyGoogleMaps.h"


@implementation MyGoogleMaps

@synthesize delegate, mapFeed, mapFeedTicket, mapFetchError, mapEditTicket;
@synthesize	featureFeed, featureFeedTicket, featureFetchError, featureEditTicket;
@synthesize username, password, userAgent;

#pragma mark -

- (id)initWithUsername:(NSString*)u password:(NSString*)p userAgent:(NSString*)ua {
	if (self = [super init]) {
    self.username = u;
    self.password = p;
    self.userAgent = ua;
	}
	return self;
}

- (void)dealloc {
  [username release];
  [password release];
  [userAgent release];
  [super dealloc];
}


#pragma mark Fetch feed of all of the user's maps

// begin retrieving the list of the user's maps
- (void)fetchFeedOfMaps {
  [self setMapFeed:nil];
  [self setMapFetchError:nil];
  [self setFeatureFeed:nil];
  [self setFeatureFeedTicket:nil];
  [self setFeatureFetchError:nil];


  GDataServiceGoogleMaps *service = [self mapService];
//	NSString *projection = kGDataMapsProjectionFull;
	NSString *projection = kGDataMapsProjectionPublic;
  NSURL *feedURL = [GDataServiceGoogleMaps mapsFeedURLForUserID:kGDataServiceDefaultUser
                                                     projection:projection];

  GDataServiceTicket *ticket;
  ticket = [service fetchFeedWithURL:feedURL
                            delegate:self
                   didFinishSelector:@selector(mapsTicket:finishedWithFeed:error:)];
  [self setMapFeedTicket:ticket];
}

// map feed fetch callback
- (void)mapsTicket:(GDataServiceTicket *)ticket
  finishedWithFeed:(GDataFeedMap *)feed
             error:(NSError *)error {

  [self setMapFeed:feed];
  [self setMapFetchError:error];
  [self setMapFeedTicket:nil];
	
	if (self.delegate) {
		[self.delegate didFetchMaps:[feed entries]];
	}
}

- (GDataEntryMap*)getMapForIdentifier:(NSString*)identifier {
	return [self.mapFeed entryForIdentifier:identifier];
}

#pragma mark Fetch a map's features
- (void)fetchFeaturesOfMapWithIdentifier:(NSString*)identifier {
	//NSLog(@"fetchFeaturesOfMapWithIdentifier: %@", identifier);
	GDataEntryMap *map = [self getMapForIdentifier:identifier];

  if (map) {
    GDataServiceGoogleMaps *service = [self mapService];

    // fetch the feed of features
    NSURL *featuresFeedURL = [map featuresFeedURL];
    if (featuresFeedURL) {

      [self setFeatureFeed:nil];
      [self setFeatureFetchError:nil];

      GDataServiceTicket *ticket;
      ticket = [service fetchFeedWithURL:featuresFeedURL
                                delegate:self
                       didFinishSelector:@selector(featuresTicket:finishedWithFeed:error:)];
      [self setFeatureFeedTicket:ticket];
    }
  }
}

// features fetch callback
- (void)featuresTicket:(GDataServiceTicket *)ticket
      finishedWithFeed:(GDataFeedMapFeature *)feed
                 error:(NSError *)error {

  [self setFeatureFeed:feed];
  [self setFeatureFetchError:error];
  [self setFeatureFeedTicket:nil];
	
	if (self.delegate) {
		[self.delegate didFetchFeatures:[feed entries]];
	}
}

#pragma mark -

// get a map service object with the current username/password
//
// A "service" object handles networking tasks.  Service objects
// contain user authentication information as well as networking
// state information (such as cookies and the "last modified" date for
// fetched data.)

- (GDataServiceGoogleMaps *)mapService {

  static GDataServiceGoogleMaps* service = nil;

  if (!service) {
    service = [[GDataServiceGoogleMaps alloc] init];

    // iPhone apps typically would not turn on the caching here
    // to avoid the memory usage
    [service setShouldCacheDatedData:YES];
    [service setServiceShouldFollowNextLinks:YES];

    // iPhone apps will typically disable caching dated data or will call
    // clearLastModifiedDates after done fetching to avoid wasting
    // memory.    
  }

  NSLog(@"Connecting to map service for %@", self.username);
  [service setUserAgent:self.userAgent];
  [service setUserCredentialsWithUsername:self.username
                                 password:self.password];

  return service;
}


@end
