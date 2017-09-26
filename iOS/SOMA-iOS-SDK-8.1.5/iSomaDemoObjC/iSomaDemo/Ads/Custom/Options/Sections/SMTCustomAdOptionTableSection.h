//
//  SMTCustomAdOptionTableSection.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMTCustomAdOptionTableSection <NSObject>

- (UITableViewCell*) cellForIndexPath:(NSIndexPath*) path forTableView:(UITableView*)tableView;
- (void) cellTouchedAtIndexPath:(NSIndexPath*) path onTableView:(UITableView*)tableView;
- (NSInteger) numberOfRows;

- (NSString*) titleForSection;
@end
