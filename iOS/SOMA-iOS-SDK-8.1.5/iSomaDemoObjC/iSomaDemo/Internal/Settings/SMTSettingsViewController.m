//
//  SMTSettingsViewController.m
//  iSomaDemo
//
//  Created by Shaikh Aman on 16/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTSettingsViewController.h"
#import "SMTAppDelegate.h"

#import "SMTSettingsAccountInfoViewController.h"
#import "SMTAppSettings.h"
#import <iSoma/iSoma.h>

@interface SMTSettingsViewController ()
@property(nonatomic, weak)IBOutlet NSLayoutConstraint* lcTopForTimeInterval;
@property(nonatomic, weak)IBOutlet NSLayoutConstraint* lcTopForGPS;
@property(nonatomic, weak)IBOutlet UIView* refreshIntervalView;
@property(nonatomic, weak)IBOutlet UILabel* lblVersion;
@property(nonatomic, weak)IBOutlet UILabel* lblRefreshIntervalValue;
@property(nonatomic, weak)IBOutlet UISwitch* autoRefreshSwitch;
@property(nonatomic, weak)IBOutlet UISwitch* gpsSwitch;
@end

@implementation SMTSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if ([iSoma isAutoReloadEnabled] == NO) {
        self.lcTopForTimeInterval.constant = -51;
        self.lcTopForGPS.constant-=51;
    }
    
    self.lblVersion.text = [NSString stringWithFormat:@"iSoma SDK %@", [iSoma SDKVersion]];
    self.gpsSwitch.on = [iSoma isGPSEnabled];
    self.autoRefreshSwitch.on = [iSoma isAutoReloadEnabled];
    int interval = [iSoma defaultAdSettings].autoReloadInterval;
    self.lblRefreshIntervalValue.text = [NSString stringWithFormat:@"Refresh interval: %d", interval];
}

- (void)viewWillDisappear:(BOOL)animated{
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(SMTAppDelegate*)[UIApplication sharedApplication].delegate showLeftEdge];
    self.lblRefreshIntervalValue.text = [NSString stringWithFormat:@"Refresh interval: %d", [iSoma autoReloadInterval]];
    self.gpsSwitch.on = [iSoma isGPSEnabled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (IBAction)onTimerIntervalSwitchValueChanged:(UISwitch*)sender{
    [[SMTAppSettings defaultSettings] setAutoReloadEnabled:sender.isOn];
    [iSoma setAutoReloadEnabled:sender.isOn];
    if (sender.isOn) {
        [iSoma setAutoReloadInterval:[SMTAppSettings defaultSettings].autoReloadInterval];
        self.lblRefreshIntervalValue.text = [NSString stringWithFormat:@"Refresh interval: %d", [SMTAppSettings defaultSettings].autoReloadInterval];
        self.lcTopForTimeInterval.constant = 1;
        self.lcTopForGPS.constant+=51;
    } else {
        [SMTAppSettings defaultSettings].autoReloadInterval = 30;
        [iSoma setAutoReloadInterval:0];
        self.lcTopForTimeInterval.constant = -51;
        self.lcTopForGPS.constant-=51;
    }
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.refreshIntervalView.alpha = sender.isOn == YES?1:0;
                         [self.view layoutIfNeeded];
                     }];
}

- (IBAction)onGPSSwitchValueChanged:(UISwitch*)sender{
    [[SMTAppSettings defaultSettings] setGpsEnabled:sender.isOn];
    [iSoma setGPSEnabled:sender.isOn];
}

- (IBAction)onHTTPSOnlySwitchValueChanged:(UISwitch*)sender{
    if (sender.isOn) {
        [iSoma setHttpsOnly:SOMAHttpsOnlyYes];
    } else {
        [iSoma setHttpsOnly:SOMAHttpsOnlyNo];
    }
}

- (IBAction)onAccountInfo:(id)sender{
    UIViewController* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"smtSettingsAccountInfo"];
    [(SMTAppDelegate*)[UIApplication sharedApplication].delegate pushViewControllerInCenterView: vc];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
