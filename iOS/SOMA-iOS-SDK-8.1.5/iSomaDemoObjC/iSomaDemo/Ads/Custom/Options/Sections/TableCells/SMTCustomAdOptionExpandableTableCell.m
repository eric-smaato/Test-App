//
//  SMTCustomAdOptionExpandableTableCell.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionExpandableTableCell.h"

@implementation SMTCustomAdOptionExpandableTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

- (BOOL) isExpanded{
	return _expanded;
}

- (void) toggleExpanded{
	_expanded = !_expanded;
	if (_expanded) {
		
	}
}

@end
