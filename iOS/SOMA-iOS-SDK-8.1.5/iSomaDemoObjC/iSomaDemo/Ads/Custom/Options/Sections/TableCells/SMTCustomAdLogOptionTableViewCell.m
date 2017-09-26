//
//  SMTCustomAdLogOptionTableViewCell.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 22/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdLogOptionTableViewCell.h"
#import "SMTCustomAdPreference.h"

@interface SMTCustomAdLogOptionTableViewCell()
@property(nonatomic, weak) IBOutlet UISwitch* logSwitch;
@property(nonatomic, weak) IBOutlet UISwitch* drawBorderSwitch;

@end;

@implementation SMTCustomAdLogOptionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onLogSwitchValueChanged:(id)sender{
	BOOL ison= self.logSwitch.isOn;
	[SMTCustomAdPreference currentPreference].logEnabled = ison;
}

- (IBAction)onDrawBorderSwitchValueChanged:(id)sender{
	BOOL ison= self.drawBorderSwitch.isOn;
	[SMTCustomAdPreference currentPreference].borderEnabled = ison;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
	self.logSwitch.on = [SMTCustomAdPreference sharedInstance].logEnabled;
	self.drawBorderSwitch.on = [SMTCustomAdPreference sharedInstance].borderEnabled;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
