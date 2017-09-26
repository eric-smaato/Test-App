//
//  SMTCustomAdOptionExpandableTableSectionFactory.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 22/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionExpandableTableSectionFactory.h"
#import "SMTCustomAdOptionExpandableTableSection.h"

@implementation SMTCustomAdOptionExpandableTableSectionFactory
- (id<SMTCustomAdOptionTableSection>) createSection:(NSDictionary*) configuration{
	NSAssert([configuration isKindOfClass:[NSDictionary class]], @"Configuration is not NSDictionary");
	
				
	NSString* title = [configuration valueForKey:kSMTCustomOptionSectionTitle];
	NSString* expandableCellTitle= [configuration valueForKey:kSMTCustomOptionSectionExpandableCellTitle];
	NSString* expandableCellId = [configuration valueForKey:kSMTCustomOptionSectionExpandableCellIdentifer];
	NSString* defaultCellId = [configuration valueForKey:kSMTCustomOptionSectionDefaultCellIdentifer];
	NSString* settingsKey = [configuration valueForKey:kSMTCustomOptionSectionSettingKey];
	BOOL valueTypeIsSize = [[configuration valueForKey:kSMTCustomOptionSectionValueTypeIsSize] boolValue];
	NSArray* values = [configuration valueForKey:kSMTCustomOptionSectionValues];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		NSMutableArray* phoneOnlyValues = [NSMutableArray new];
		for (NSDictionary* value in values) {
			if ([[value valueForKey:kSMTCustomOptionSectionValueIPADOnlyValue] boolValue] == NO) {
				[phoneOnlyValues addObject:value];
			}
		}
		
		values = [phoneOnlyValues copy];
	}
	
	NSAssert([expandableCellId length]>0, @"Expandable cell identifier is empty");
	NSAssert([expandableCellTitle length]>0, @"Expandable cell title is empty");
	NSAssert([defaultCellId length]>0, @"Default cell identifier is empty");
	NSAssert([values isKindOfClass:[NSArray class]], @"Section values must be of type NSArray");
	NSAssert([values count] > 0, @"Section has no value");
	NSAssert([settingsKey length]>0, @"Settings key cannot be empty");
	
	
	SMTCustomAdOptionExpandableTableSection* section = [[SMTCustomAdOptionExpandableTableSection alloc] init];
	
	section.title = title;
	section.expandableCellTitle = expandableCellTitle;
	section.expandableCellId = expandableCellId;
	section.settingsKey = settingsKey;
	section.defaultCellId = defaultCellId;
	section.valueTypeIsSize = valueTypeIsSize;
	section.values = values;
	
	return section;
}
@end
