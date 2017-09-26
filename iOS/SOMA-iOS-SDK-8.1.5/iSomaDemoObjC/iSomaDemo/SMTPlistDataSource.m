//
//  SMTPlistDataSource.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTPlistDataSource.h"

#define kDemoPlistDataViewControllerId @"viewControllerId"
#define kDemoPlistDataTitle @"title"
#define kDemoPlistDataDescription @"description"
#define kDemoPlistDataIcon @"icon"
#define kDemoPlistDataCompatibleDeviceFamily @"compatibleDeviceFamily"


@implementation SMTPlistDataSource{
	NSArray*	_plistData;
	NSString*	_plistFilePath;
}

-(id)init{
	[NSException raise:@"SMTPlistDataSource init called"
				format:@"Please use [SMTData plistDataSource]"];
	return nil;
}

- (NSArray*) allKeys{
	return
	[NSArray arrayWithObjects:kDemoPlistDataViewControllerId
	 , kDemoPlistDataTitle
	 , kDemoPlistDataDescription
	 , kDemoPlistDataIcon
	 , kDemoPlistDataCompatibleDeviceFamily
	 , nil];
}

- (void) loadPlistFileAtPath:(NSString*)filePath{
	NSAssert([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES
			 , ([NSString stringWithFormat:@"Plist file does not exist:%@", filePath]));
	
	NSArray* allData = [NSArray arrayWithContentsOfFile:filePath];
	
	NSAssert(allData !=nil
			 , ([NSString stringWithFormat:@"%@ file not loaded", _plistFilePath]));
	NSAssert([allData count] >0, @"Plist has empty data");
	
	// Validate plist file
	NSArray* keys = [self allKeys];
	
	NSMutableArray* dataForCurrentDevice = [NSMutableArray new];
	NSString* currentDeviceFamily = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? @"ipad" : @"iphone";
	
	for (NSDictionary* entry in allData) {
		static int index = 0;
//		NSLog(@"Validating plist file entry at index: %d", index);
		
		// check if all the keys are present and they have value
		NSArray* allKeys =[entry allKeys];
		#pragma unused(allKeys)
		for (NSString* key in keys) {
			#pragma unused(key)
			NSAssert([allKeys containsObject:key]
					 , ([NSString stringWithFormat:@"\"%@\" key not present at index: %d", key, index]));
		}
		NSString* compatibleDeviceFamily = [entry valueForKey:kDemoPlistDataCompatibleDeviceFamily];
		if ([compatibleDeviceFamily caseInsensitiveCompare:@"all"] == NSOrderedSame || [compatibleDeviceFamily caseInsensitiveCompare:currentDeviceFamily] == NSOrderedSame) {
			[dataForCurrentDevice addObject:entry];
		}
		
		index++;
	}
	
	_plistData = [dataForCurrentDevice copy];
}

-(instancetype) initWithPlistFileAtPath:(NSString*) filePath{
	self = [super init];
	if (self) {
		[self loadPlistFileAtPath:filePath];
	}
	return self;
}

#pragma mark - SMTDataSource protocol implementation
 -(NSUInteger) numberOfDemoAds{
    return [_plistData count];
}

-(UIViewController*) viewControllerForIndexPath:(NSIndexPath*) path{
	NSAssert([_plistData count] > path.row, @"out of bound for row in plist data:%d",(int)path.row);
	NSString* storyboardId = [_plistData[path.row] objectForKey:kDemoPlistDataViewControllerId];
	
	// Note: if the storyboard name is invalid, it will give compile time error, so need to validate or DI storyboard id or view controlelr identifier
	UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"AdViewControllers" bundle:[NSBundle mainBundle]];
	return [storyBoard instantiateViewControllerWithIdentifier:storyboardId];
}
-(NSString*) titleForIndexPath:(NSIndexPath*) path{
	NSAssert([_plistData count] > path.row, @"out of bound for row in plist data:%d",(int)path.row);
	
	NSDictionary* entry = _plistData[path.row];
	return [entry objectForKey:kDemoPlistDataTitle];
}
-(NSString*) descriptionForIndexPath:(NSIndexPath*) path{
	NSAssert([_plistData count] > path.row, @"out of bound for row in plist data:%ld",(long)path.row);
	NSDictionary* entry = _plistData[path.row];
	return [entry objectForKey:kDemoPlistDataDescription];
}
-(UIImage*) iconForIndexPath:(NSIndexPath*) path{
	NSAssert([_plistData count] > path.row, @"out of bound for row in plist data:%ld",(long)path.row);
	NSDictionary* entry = _plistData[path.row];
	return [UIImage imageNamed:[entry objectForKey:kDemoPlistDataIcon]];
}
@end
