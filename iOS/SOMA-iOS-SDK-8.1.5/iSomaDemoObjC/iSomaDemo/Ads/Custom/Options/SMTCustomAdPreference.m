//
//  SMTCustomAdSettings.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 22/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdPreference.h"
#import <iSoma/SOMATypes.h>


@implementation SMTCustomAdPreference

- (id) init{
	self = [super init];
	if (self) {
		[self reset];
	}
	return self;
}

- (void)reset{
	_logEnabled = YES;
	_borderEnabled = NO;
	_type = @"ALL";
	_dimension = @"Any";
	_widthHeight = @"Any";
}

+ (instancetype) sharedInstance{
	static id _sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedInstance = [SMTCustomAdPreference new];
	});
	return _sharedInstance;
}
+ (instancetype) currentPreference{
	static id _instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [SMTCustomAdPreference new];
	});
	return _instance;
}

- (NSString*)dimension{
	if (_dimension.length > 0) {
		return _dimension;
	}
	return nil;
}

- (SOMAAdType) typeValue{
	if ([self.type caseInsensitiveCompare:@"TXT"] == NSOrderedSame) {
		return SOMAAdTypeText;
	}
	if ([self.type caseInsensitiveCompare:@"IMG"] == NSOrderedSame) {
		return SOMAAdTypeImage;
	}
	if ([self.type caseInsensitiveCompare:@"RICHMEDIA"] == NSOrderedSame) {
		return SOMAAdTypeRichMedia;
	}
	if ([self.type caseInsensitiveCompare:@"VIDEO"] == NSOrderedSame) {
		return SOMAAdTypeVideo;
	}
	return SOMAAdTypeAll;
}

- (SOMAAdDimension) dimensionValue{
	if ([self.dimension caseInsensitiveCompare:@"MMA"]) {
		return SOMAAdDimensionMMA;
	}
	
	if ([self.dimension caseInsensitiveCompare:@"MEDRECT"]) {
		return SOMAAdDimensionMedRect;
	}
	if ([self.dimension caseInsensitiveCompare:@"MMA"]) {
		return SOMAAdDimensionMMA;
	}
	if ([self.dimension caseInsensitiveCompare:@"XLARGE"]) {
		return SOMAAdDimensionXLARGE;
	}
	if ([self.dimension caseInsensitiveCompare:@"XXLARGE"]) {
		return SOMAAdDimensionXXLARGE;
	}
	if ([self.dimension caseInsensitiveCompare:@"LEADER"]) {
		return SOMAAdDimensionLeader;
	}
	
	if ([self.dimension caseInsensitiveCompare:@"SKY"]) {
		return SOMAAdDimensionSky;
	}
	
	return SOMAAdDimensionDefault;;
}


- (NSString*)widthHeight{
	if (_widthHeight.length > 0) {
		return _widthHeight;
	}
	return nil;
}

- (NSInteger) width{
	if ([self.widthHeight caseInsensitiveCompare:@"any"] == NSOrderedSame) {
		return 0;
	}
	
	NSArray* array = [self.widthHeight componentsSeparatedByString:@"x"];
	NSAssert([array count] == 2, @"Width and Height should be separated by 'x', e.g. 320x50");
	int width = [array[0] intValue];
	NSAssert(width, @"Width must be a positive numeric value");
	return width;
}

- (NSInteger) height{
	if ([self.widthHeight caseInsensitiveCompare:@"any"] == NSOrderedSame) {
		return 0;
	}
	
	NSArray* array = [self.widthHeight componentsSeparatedByString:@"x"];
	NSAssert([array count] == 2, @"Width and Height should be separated by 'x', e.g. 320x50");
	int height = [array[1] intValue];
	NSAssert(height, @"Height must be a positive numeric value");
	return height;
}

- (NSString *)description{
	return [NSString stringWithFormat:@"type=%@, dim=%@, wh=%@, log=%@", self.type, self.dimension, self.widthHeight, self.isLogEnabled == YES?@"YES":@"NO"];
}

- (void) update:(SMTCustomAdPreference*) settings{
	self.logEnabled = settings.logEnabled;
	self.type = settings.type;
	self.dimension = settings.dimension;
	self.widthHeight = settings.widthHeight;
	self.borderEnabled = settings.borderEnabled;
}
@end
