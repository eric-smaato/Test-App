//
//  SMTCustomAdSettings.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 22/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iSoma/SOMATypes.h>

@interface SMTCustomAdPreference : NSObject

@property(nonatomic, assign, getter = isLogEnabled) BOOL logEnabled;
@property(nonatomic, assign, getter = isDrawBorderEnabled) BOOL borderEnabled;
@property(nonatomic, strong) NSString* type;
@property(nonatomic, strong) NSString* dimension;
@property(nonatomic, strong) NSString* widthHeight;

- (NSInteger) width;
- (NSInteger) height;
- (SOMAAdDimension) dimensionValue;
- (SOMAAdType) typeValue;
- (void) update:(SMTCustomAdPreference*) settings;

- (void) reset;
+ (instancetype) sharedInstance;
+ (instancetype) currentPreference;

@end
