//
//  SMTAdShowcaseTableViewCell.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 23/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTAdShowcaseTableViewCell.h"

@implementation SMTAdShowcaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
	self.imageBackgroundView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
