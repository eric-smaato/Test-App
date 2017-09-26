//
//  SMTCustomAdOptionTableSection.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionExpandableTableSection.h"
#import "SMTCustomAdOptionConstants.h"
#import "SMTCustomAdOptionConstants.h"
#import "SMTCustomAdOptionExpandableTableCell.h"
#import "SMTCustomAdPreference.h"

@implementation SMTCustomAdOptionExpandableTableSection{		
	NSUInteger _selectedValueIndex;
}

- (id)init{
	self = [super init];
	if (self) {
		_selectedValueIndex = 0;
	}
	return self;
}

- (UITableViewCell*) cellForIndexPath:(NSIndexPath*) path forTableView:(UITableView*)tableView{
	
	NSString* cellTitle;
	NSString* cellDetail;
	NSString* identifer;
	
	UITableViewCellAccessoryType accessory = UITableViewCellAccessoryNone;
	if (path.row == 0) {
		identifer = _expandableCellId;
		cellTitle = _expandableCellTitle;
		cellDetail = [[SMTCustomAdPreference currentPreference] valueForKey:self.settingsKey];
		if (!self.isExpanded) {
			accessory = UITableViewCellAccessoryDisclosureIndicator;
		}
	} else {
		identifer = _defaultCellId;
		NSDictionary* valueData = _values[path.row-1];
		cellTitle = [valueData valueForKey:kSMTCustomOptionSectionValueTitle];
		cellDetail = [valueData valueForKey:kSMTCustomOptionSectionValueDescription];
		NSString* settingsValue = [valueData valueForKey:kSMTCustomOptionSectionValueValue];
		if ([settingsValue compare:[[SMTCustomAdPreference currentPreference] valueForKey:self.settingsKey]] ==NSOrderedSame){
			accessory = UITableViewCellAccessoryCheckmark;
		}
	}
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer];
	cell.textLabel.text = cellTitle;
	cell.detailTextLabel.text = cellDetail;
	cell.accessoryType = accessory;
	
	return cell;
}

- (void) cellTouchedAtIndexPath:(NSIndexPath*) indexPath onTableView:(UITableView*)tableView{
	if (indexPath.row != 0) {

		_selectedValueIndex = indexPath.row-1;
		NSDictionary* valueData = _values[indexPath.row-1];
		NSString* settingsValue = [valueData valueForKey:kSMTCustomOptionSectionValueValue];
		
		[[SMTCustomAdPreference currentPreference] setValue:settingsValue forKey:self.settingsKey];
		
		[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]].detailTextLabel setText:settingsValue];
	}
	
	[self toggleExpandedAtIndexPath:indexPath withTableView:tableView];
//	[CATransaction begin];
//	[CATransaction setCompletionBlock:^{
//		
//	}];
//	
////	[tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
//	[CATransaction commit];
}

- (void) toggleExpandedAtIndexPath:(NSIndexPath*)indexPath withTableView:(UITableView*)tableView{
	self.expanded = !self.isExpanded;
	
	NSMutableArray* indexArray = [NSMutableArray new];
	for (int i =0; i<[_values count]; i++) {
		NSIndexPath* path1 = [NSIndexPath indexPathForRow:i+1 inSection:indexPath.section];
		[indexArray addObject:path1];
	}
	
	if (self.isExpanded) {
		// add rows
		[tableView insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
		[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]] setAccessoryType:UITableViewCellAccessoryNone];
		
	}else {
		// remove rows
		[tableView deleteRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
		[[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]] setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
}

- (NSInteger) numberOfRows{
	if (self.isExpanded) {
		return [_values count] + 1;
	}
	return 1;
}

- (NSString*) titleForSection{
	return _title;
}
@end
