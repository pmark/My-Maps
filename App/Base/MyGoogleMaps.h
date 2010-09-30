//
//  MyGoogleMaps.h
//  CoffeeCommuter
//
//  Created by P. Mark Anderson on 10/12/09.
//  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
//


#import "GDataMaps.h"

@protocol MyGoogleMapsDelegate
- (void)didFetchMaps:(NSArray*)maps;
- (void)didFetchFeatures:(NSArray*)features;
@end


@interface MyGoogleMaps : NSObject {
  GDataFeedMap *mapFeed;
  GDataServiceTicket *mapFeedTicket;
  NSError *mapFetchError;

  GDataServiceTicket *mapEditTicket;

  GDataFeedMapFeature *featureFeed;
  GDataServiceTicket *featureFeedTicket;
  NSError *featureFetchError;

  GDataServiceTicket *featureEditTicket;
	id<MyGoogleMapsDelegate> delegate;
  NSString *username;
  NSString *password;  
  NSString *userAgent;  
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *userAgent;

@property (nonatomic, retain) GDataFeedMap *mapFeed;
@property (nonatomic, retain) GDataServiceTicket *mapFeedTicket;
@property (nonatomic, retain) NSError	*mapFetchError;
@property (nonatomic, retain) GDataServiceTicket *mapEditTicket;
@property (nonatomic, retain) GDataFeedMapFeature *featureFeed;
@property (nonatomic, retain) GDataServiceTicket *featureFeedTicket;
@property (nonatomic, retain) NSError	*featureFetchError;
@property (nonatomic, retain) GDataServiceTicket *featureEditTicket;
@property (nonatomic, retain) id<MyGoogleMapsDelegate> delegate;

- (id)initWithUsername:(NSString*)u password:(NSString*)p userAgent:(NSString*)ua;
- (void)fetchFeedOfMaps;
- (void)fetchFeaturesOfMapWithIdentifier:(NSString*)identifier;
- (GDataEntryMap*)getMapForIdentifier:(NSString*)identifier;
- (GDataServiceGoogleMaps*)mapService;

@end
