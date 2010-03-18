//
//  MyMapsSession.h
//
//  Created by P. Mark Anderson on 5/7/09.
//  Copyright 2009 Bordertown Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SM3DAR.h"

@interface MyMapsSession : NSObject {
	BOOL networkIsReachable;
}

@property BOOL networkIsReachable;

+ (MyMapsSession*)sharedMyMapsSession;
+ (NSString*)applicationDocumentsDirectory;

- (void)setup;
- (void)updateReachabilityStatus;

@end
