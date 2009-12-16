/*
 *  MyMaps.h
 *  MyMaps
 *
 *  Created by P. Mark Anderson on 12/16/09.
 *  Copyright 2009 Bordertown Labs, LLC. All rights reserved.
 *
 */

#import "KeychainWrapper.h"
#define KEYCHAIN_SAVE_STRING( name, value ) [KeychainWrapper writeString:value toKeychainForKey:name]
#define KEYCHAIN_READ_STRING( name ) (NSString *)[KeychainWrapper readStringFromKeychainForKey:name]
#define KEYCHAIN_HOST @"mymaps.spotmetrix.com"

#define PREF_SAVE_OBJECT(name, value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:name]
#define PREF_READ_OBJECT(name) [[NSUserDefaults standardUserDefaults] objectForKey:name]
#define PREF_READ_ARRAY(name) (NSArray*)PREF_READ_OBJECT(name)
#define PREF_READ_DICTIONARY(name) (NSDictionary*)PREF_READ_OBJECT(name)
#define PREF_SAVE_BOOL(name, value) [[NSUserDefaults standardUserDefaults] setBool:value forKey:name]
#define PREF_READ_BOOL(name) [[NSUserDefaults standardUserDefaults] boolForKey:name]
#define PREF_EXISTS(name) [[NSUserDefaults standardUserDefaults] objectForKey:name] != nil

#define PREF_USERNAME @"PREF_USERNAME"
#define PREF_PASSWORD @"PREF_PASSWORD"
