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
  SM3DAR_Controller *sm3dar;
}

@property BOOL networkIsReachable;
@property (nonatomic, retain) SM3DAR_Controller *sm3dar;

+ (MyMapsSession*)sharedMyMapsSession;
+ (NSString*)applicationDocumentsDirectory;

- (void)setup;
- (void)updateReachabilityStatus;

@end
