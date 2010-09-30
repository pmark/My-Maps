//
//  KeychainWrapper.m
//
//

#import "KeychainWrapper.h"


@implementation KeychainWrapper


+ (NSURLProtectionSpace*) protectionSpaceForKey:(NSString*)key {
	NSURLProtectionSpace *protectionSpace = nil;
  
	if ([key isEqualToString:PREF_USERNAME] || [key isEqualToString:PREF_PASSWORD]) {
		protectionSpace = [[[NSURLProtectionSpace alloc] initWithHost:KEYCHAIN_HOST
                                                            port:0
                                                        protocol:@"https"
                                                           realm:nil
                                            authenticationMethod:nil] autorelease];
	}
	return protectionSpace;
}

+ (void) writeString:(NSString*)string toKeychainForKey:(NSString*)key {
	NSURLProtectionSpace *protectionSpace = [KeychainWrapper protectionSpaceForKey:key];
	
	NSURLCredential *oldCredential = [[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:protectionSpace];
	NSURLCredential *newCredential = nil;
	
	if ([key isEqualToString:PREF_PASSWORD]) {
		if (oldCredential == nil) {
			newCredential = [NSURLCredential credentialWithUser:@"" password:string persistence:NSURLCredentialPersistencePermanent];
		} else {
			newCredential = [NSURLCredential credentialWithUser:[oldCredential user] password:string persistence:NSURLCredentialPersistencePermanent];
		}
	} else if ([key isEqualToString:PREF_USERNAME]) {
		if (oldCredential == nil) {
			newCredential = [NSURLCredential credentialWithUser:string password:@"" persistence:NSURLCredentialPersistencePermanent];
		} else {
			newCredential = [NSURLCredential credentialWithUser:string password:[oldCredential password] persistence:NSURLCredentialPersistencePermanent];
		}
	}
  
	while ([[[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:protectionSpace] count] > 0) {
		NSString *key = [[[[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:protectionSpace] allKeys] objectAtIndex:0];
		NSURLCredential *credential = [[[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:protectionSpace] objectForKey:key];
		[[NSURLCredentialStorage sharedCredentialStorage] removeCredential:credential forProtectionSpace:protectionSpace];
	}
  
	[[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:newCredential forProtectionSpace:protectionSpace];
}

+ (NSString*) readStringFromKeychainForKey:(NSString*)key {
	NSURLProtectionSpace *protectionSpace = [KeychainWrapper protectionSpaceForKey:key];
  
	NSURLCredential *credential = [[NSURLCredentialStorage sharedCredentialStorage] defaultCredentialForProtectionSpace:protectionSpace];
  
	if ([key isEqualToString:PREF_PASSWORD]) {
		return [credential password];
	} else if ([key isEqualToString:PREF_USERNAME]) {
		return [credential user];
	}
	return nil;
}

@end
