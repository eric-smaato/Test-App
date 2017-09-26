//
//  SMTCustomAdOptionTableSectionManager.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionConstants.h"
#import "SMTCustomAdOptionTableManager.h"
#import "SMTCustomAdOptionExpandableTableSection.h"
#import "SMTCustomAdOptionExpandableTableSectionFactory.h"

@implementation SMTCustomAdOptionTableManager{
	NSArray* _sections;
	NSDictionary* _factoriesForSections;
}

-(id)init{
	[NSException raise:@"SMTCustomAdOptionTableSectionManagerError" format:@"Please use sharedInstance"];
	return nil;
}

- (id) initWithConfigurationFile:(NSString*)filePath{
	self = [super init];
	if (self) {
		NSString* path = [[NSBundle mainBundle] pathForResource:@"SMTAdOptionTableSectionFactoryConfiguration" ofType:@"plist"];
		NSAssert([[NSFileManager defaultManager] fileExistsAtPath:path] == YES
				 , ([NSString stringWithFormat:@"SMTAdOptionTableSectionFactoryConfiguration.plist file does not exist:%@", path]));
		
		_factoriesForSections = [NSDictionary dictionaryWithContentsOfFile:path];
		NSAssert([_factoriesForSections isKindOfClass:[NSDictionary class]], @"SMTAdOptionTableSectionFactoryConfiguration.plist is not a dictionary");
				
		
		NSArray* configuration = [NSArray arrayWithContentsOfFile:filePath];
		
		NSAssert(configuration != nil, @"Invalid Custom ad configuraiton file");
		NSMutableArray* sections = [NSMutableArray new];
		
		for (NSDictionary* dic in configuration) {
			NSAssert([dic isKindOfClass:[NSDictionary class]], @"Invalid Custom ad configuraiton file: section data must be NSDictionary");
			
			// Get the section class
			NSString* sectionClass = [dic valueForKey:kSMTCustomOptionSectionClass];
			
			NSAssert([sectionClass isKindOfClass:[NSString class]], @"section class must be NSString");
			NSAssert([sectionClass length]>3, @"section class cannot be empty");
			
			NSAssert(NSClassFromString(sectionClass), ([NSString stringWithFormat:@"No class found: %@", sectionClass]));
			
			
			
			// get the factory
			NSString* factoryClassName = _factoriesForSections[sectionClass];
			
			NSAssert([factoryClassName isKindOfClass:[NSString class]], @"Section factory class must be NSString");
			
			NSAssert([factoryClassName length]>3, @"Section flactory class cannot be empty");
			
			NSAssert(NSClassFromString(factoryClassName), ([NSString stringWithFormat:@"No class found: %@", factoryClassName]));
			
			id<SMTCustomAdOptionTableSectionFactory> sectionFactory = [[NSClassFromString(factoryClassName) alloc] init];
			
			NSAssert([sectionFactory conformsToProtocol:@protocol(SMTCustomAdOptionTableSectionFactory)], ([NSString stringWithFormat:@"%@ doesn't confront to SMTCustomAdOptionTableSectionFactory porotocol", sectionClass]));
			
			
			id<SMTCustomAdOptionTableSection> section = [sectionFactory createSection:dic];
						
			NSAssert([section conformsToProtocol:@protocol(SMTCustomAdOptionTableSection)], ([NSString stringWithFormat:@"%@ doesn't confront to SMTCustomAdOptionTableSection porotocol", sectionClass]));
			[sections addObject:section];						
		}
		
		_sections = [sections copy];
	}
	return self;
}
- (id<SMTCustomAdOptionTableSection>) sectionAtIndex:(NSInteger)index{
	NSAssert(_sections.count > index, @"Table doesn't have this much sections!!");
	return _sections[index];
}
- (NSInteger) numberSections{
	return [_sections count];
}
- (NSInteger) rowsForSection:(NSInteger)sectionIndex{
	NSAssert(_sections.count > sectionIndex, @"Table doesn't have this much sections!!");
	
	NSInteger count = 0;
	id<SMTCustomAdOptionTableSection> section = _sections[sectionIndex];
	
	NSAssert([section conformsToProtocol:@protocol(SMTCustomAdOptionTableSection)], @"Section doesn't confront to SMTCustomAdOptionTableSection protocol");
	
	count = [section numberOfRows];
	return count;
}

+ (instancetype) createManager{
	static id _instance = nil;
	NSString* path = [[NSBundle mainBundle] pathForResource:@"SMTCustomAdOptionSectionConfiguration" ofType:@"plist"];
	NSAssert([[NSFileManager defaultManager] fileExistsAtPath:path] == YES
			 , ([NSString stringWithFormat:@"SMTCustomAdOptionSectionConfiguration.plist file does not exist:%@", path]));
	_instance = [[SMTCustomAdOptionTableManager alloc] initWithConfigurationFile:path];
	return _instance;
}
@end
