//
//  KeychainWrapper.h
//
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "MyMaps.h"

@interface KeychainWrapper : NSObject {
}

+(NSURLProtectionSpace*) protectionSpaceForKey:( NSString *)key;
+(void) writeString:(NSString*)string toKeychainForKey:(NSString*)key;
+(NSString*) readStringFromKeychainForKey:(NSString*)key;
			
@end
