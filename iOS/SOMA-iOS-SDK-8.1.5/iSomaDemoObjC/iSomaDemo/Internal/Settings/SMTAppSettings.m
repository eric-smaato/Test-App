//
//  SMTAppSettings.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 28/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTAppSettings.h"
#import <iSoma/iSoma.h>

NSString* const autoReloadIntervalKey = @"autoReloadInterval";
NSString* const autoReloadEnabledKey = @"autoReloadEnabled";
NSString* const isGPSEnabledKey = @"isGpsEnabled";
NSString* const adSpaceIDKey = @"adSpaceID";
NSString* const adPublisherIDKey = @"adPublisherID";
NSString* const testAdSpaceIDKey = @"testAdSpaceID";
NSString* const testAdPublisherIDKey = @"testAdPublisherID";
NSString* const testModeEnabledKey = @"testModeEnabled";

@implementation SMTAppSettings

+(instancetype) defaultSettings{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [SMTAppSettings new];
        
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *defaultNSUserDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [NSNumber numberWithInt:0], testAdPublisherIDKey,
                                               [NSNumber numberWithInt:0], testAdSpaceIDKey,
                                               [NSNumber numberWithInt:[iSoma defaultAdSettings].autoReloadInterval], autoReloadIntervalKey,
                                               [NSNumber numberWithBool:[iSoma defaultAdSettings].autoReloadEnabled], autoReloadEnabledKey,
                                               nil];
        [userDefaults registerDefaults:defaultNSUserDefaults];
        [iSoma setGPSEnabled:YES];
        [iSoma setLogLevel:SOMALogLevelNone];
    });
    
    return _instance;
}

- (BOOL)isGpsEnabled{
    return [[NSUserDefaults standardUserDefaults] boolForKey:isGPSEnabledKey];
}

- (void)setGpsEnabled:(BOOL)gpsEnabled{
    [[NSUserDefaults standardUserDefaults] setBool:gpsEnabled forKey:isGPSEnabledKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isAutoReloadEnabled{
    return [[NSUserDefaults standardUserDefaults] boolForKey:autoReloadEnabledKey];
}

- (void)setAutoReloadEnabled:(BOOL)autoReloadEnabled{
    [[NSUserDefaults standardUserDefaults] setBool:autoReloadEnabled forKey:autoReloadEnabledKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)autoReloadInterval{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:autoReloadIntervalKey] intValue];
}

- (void)setAutoReloadInterval:(int)autoReloadInterval{
    [[NSUserDefaults standardUserDefaults] setInteger:autoReloadInterval forKey:autoReloadIntervalKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)adSpaceID{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:adSpaceIDKey] intValue];
}

- (void)setAdSpaceID:(int)adSpaceID{
    [[NSUserDefaults standardUserDefaults] setInteger:adSpaceID forKey:adSpaceIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)adPublisherID{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:adPublisherIDKey] intValue];
}

- (void)setAdPublisherID:(int)adPublisherID{
    [[NSUserDefaults standardUserDefaults] setInteger:adPublisherID forKey:adPublisherIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Test mode
- (int)testAdSpaceID{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:testAdSpaceIDKey] intValue];
}

- (void)setTestAdSpaceID:(int)testAdSpaceID{
    [[NSUserDefaults standardUserDefaults] setInteger:testAdSpaceID forKey:testAdSpaceIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (int)testAdPublisherID{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:testAdPublisherIDKey] intValue];
}

- (void)setTestAdPublisherID:(int)testAdPublisherID{
    [[NSUserDefaults standardUserDefaults] setInteger:testAdPublisherID forKey:testAdPublisherIDKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isTestModeEnabled{
    return [[NSUserDefaults standardUserDefaults] boolForKey:testModeEnabledKey];
}

- (void)setTestModeEnabled:(BOOL)enabled{
    [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:testModeEnabledKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//

- (void)load {
    [iSoma setAutoReloadEnabled:[SMTAppSettings defaultSettings].isAutoReloadEnabled];
    [iSoma setAutoReloadInterval:(int)[SMTAppSettings defaultSettings].autoReloadInterval];
    [iSoma defaultAdSettings].publisherId = [SMTAppSettings defaultSettings].adPublisherID;
    [iSoma defaultAdSettings].adSpaceId = [SMTAppSettings defaultSettings].adSpaceID;
}

- (void)save {
    [[SMTAppSettings defaultSettings] setAutoReloadEnabled:[iSoma isAutoReloadEnabled]];
    [[SMTAppSettings defaultSettings] setAutoReloadInterval:[iSoma autoReloadInterval]];
    [[SMTAppSettings defaultSettings] setAdPublisherID:(int)[iSoma defaultAdSettings].publisherId];
    [[SMTAppSettings defaultSettings] setAdSpaceID:(int)[iSoma defaultAdSettings].adSpaceId];
}

@end

