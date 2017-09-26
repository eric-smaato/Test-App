//
//  SMTAppSettings.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 28/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMTAppSettings : NSObject
@property(nonatomic, assign) int adSpaceID;
@property(nonatomic, assign) int adPublisherID;
@property(nonatomic, assign) int testAdSpaceID;
@property(nonatomic, assign) int testAdPublisherID;
@property(nonatomic, assign, getter=isGpsEnabled) BOOL gpsEnabled;
@property(nonatomic, assign, getter=isAutoReloadEnabled) BOOL autoReloadEnabled;
@property(nonatomic, assign) int autoReloadInterval; // seconds
@property(nonatomic, assign, getter = isTestModeEnabled) BOOL testModeEnabled;

+(instancetype) defaultSettings;
-(void)load;
-(void)save;

@end
