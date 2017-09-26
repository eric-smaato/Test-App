//
//  SMTSettingsRefreshTimeViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 28/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTSettingsRefreshTimeViewController.h"
#import "SMTAppDelegate.h"
#import "SMTAppSettings.h"
#import <iSoma/iSoma.h>

#define kMaxAutoReloadInterval 240
#define kMinAutoReloadInterval 10

@interface SMTSettingsRefreshTimeViewController ()
@property(nonatomic, weak) IBOutlet UIButton* btnMinus;
@property(nonatomic, weak) IBOutlet UIButton* btnPlus;
@property(nonatomic, weak) IBOutlet UILabel* lblInterval;
@end

@implementation SMTSettingsRefreshTimeViewController

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
    
    self.btnPlus.enabled = [iSoma autoReloadInterval] < kMaxAutoReloadInterval;
    self.btnMinus.enabled = [iSoma autoReloadInterval] > kMinAutoReloadInterval;
    
    [self updateIntervalText];
    
    self.btnMinus.layer.cornerRadius = self.btnMinus.frame.size.width/2;
    self.btnPlus.layer.cornerRadius = self.btnPlus.frame.size.width/2;
}

- (void) updateIntervalText{
    self.lblInterval.text = [NSString stringWithFormat:@"%d seconds", [iSoma autoReloadInterval]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(SMTAppDelegate*)[UIApplication sharedApplication].delegate hideLeftEdge];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [(SMTAppDelegate*)[UIApplication sharedApplication].delegate showLeftEdge];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMinus:(id)sender{
    int currentValue = [iSoma autoReloadInterval];
    currentValue -= 10;
    
    if (currentValue > kMinAutoReloadInterval) {
        self.btnPlus.enabled = YES;
    } else {
        currentValue = kMinAutoReloadInterval;
        self.btnMinus.enabled = NO;
    }
    [SMTAppSettings defaultSettings].autoReloadInterval = currentValue;
    [iSoma setAutoReloadInterval:currentValue];
    [self updateIntervalText];
}
- (IBAction)onPlus:(id)sender{
    int currentValue = [iSoma autoReloadInterval];
    currentValue += 10;
    
    if (currentValue < kMaxAutoReloadInterval) {
        self.btnMinus.enabled = YES;
    } else {
        currentValue = kMaxAutoReloadInterval;
        self.btnPlus.enabled = NO;
    }
    [SMTAppSettings defaultSettings].autoReloadInterval = currentValue;
    [iSoma setAutoReloadInterval:currentValue];
    [self updateIntervalText];
}

@end
