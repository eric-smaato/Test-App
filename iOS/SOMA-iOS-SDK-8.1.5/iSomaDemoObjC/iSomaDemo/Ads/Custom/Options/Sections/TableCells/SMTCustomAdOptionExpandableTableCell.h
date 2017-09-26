//
//  SMTCustomAdOptionExpandableTableCell.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTCustomAdOptionExpandableTableCell : UITableViewCell
@property(nonatomic, assign, getter = isExpanded) BOOL expanded;
- (void) toggleExpanded;
@end
