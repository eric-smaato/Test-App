//
//  SMTCustomAdOptionDefaultTableSectionFactory.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 22/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionDefaultTableSectionFactory.h"
#import "SMTCustomAdOptionDefaultTableSection.h"

@implementation SMTCustomAdOptionDefaultTableSectionFactory
- (id<SMTCustomAdOptionTableSection>) createSection:(NSDictionary*) configuration{
	NSAssert([configuration isKindOfClass:[NSDictionary class]], @"Configuration is not NSDictionary");
	NSAssert([configuration isKindOfClass:[NSDictionary class]], @"Configuration is not NSDictionary");
	
	
	NSString* title = [configuration valueForKey:kSMTCustomOptionSectionTitle];
	NSArray* values = [configuration valueForKey:kSMTCustomOptionSectionValues];
	
	NSAssert([values isKindOfClass:[NSArray class]], @"Section values must be of type NSArray");
	NSAssert([values count] > 0, @"Section has no value");
	
	
	SMTCustomAdOptionDefaultTableSection* section = [SMTCustomAdOptionDefaultTableSection new];
	section.title = title;
	section.values = values;
	return section;
}
@end
