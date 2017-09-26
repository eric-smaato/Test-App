//
//  SMTCustomAdOptionDefaultTableSection.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionDefaultTableSection.h"
#import "SMTCustomAdOptionConstants.h"

@implementation SMTCustomAdOptionDefaultTableSection

- (UITableViewCell*) cellForIndexPath:(NSIndexPath*) path forTableView:(UITableView*)tableView{
	
	NSString* identifer = _values[path.row];
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifer];
	return cell;
}
- (void) cellTouchedAtIndexPath:(NSIndexPath*) path onTableView:(UITableView*)tableView{
}
- (NSInteger) numberOfRows{
	return [_values count];
}

- (NSString*) titleForSection{
	return _title;
}
@end
