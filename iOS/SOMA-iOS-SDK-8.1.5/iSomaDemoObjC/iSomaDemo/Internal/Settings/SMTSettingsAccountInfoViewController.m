//
//  SMTSettingsAccountInfoViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 24/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTSettingsAccountInfoViewController.h"
#import "SMTAppDelegate.h"
#import "SMTAppSettings.h"
#import <iSoma/iSoma.h>

@interface SMTSettingsAccountInfoViewController ()
@property(nonatomic, weak) IBOutlet UITextField* txtPublisher;
@property(nonatomic, weak) IBOutlet UITextField* txtAdSpace;
@property(nonatomic, weak) IBOutlet UISwitch* testModeSwitch;
@end

@implementation SMTSettingsAccountInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [(SMTAppDelegate*)[UIApplication sharedApplication].delegate hideLeftEdge];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.testModeSwitch.on = [SMTAppSettings defaultSettings].testModeEnabled;
    UIFont *font = [UIFont systemFontOfSize:12];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjects:@[font,[UIColor lightTextColor]]
                                                                forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName ]];
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"Enter your Publisher ID" attributes:attrsDictionary];
    
    self.txtPublisher.attributedPlaceholder = attrString;
    attrString = [[NSAttributedString alloc] initWithString:@"Enter your AdSpace ID" attributes:attrsDictionary];
    self.txtAdSpace.attributedPlaceholder = attrString;
    
    [self.testModeSwitch setOn:[SMTAppSettings defaultSettings].isTestModeEnabled];
    [self onTestModeValueChanged:self.testModeSwitch];
}

- (IBAction)onTestModeValueChanged:(id)sender{
    [SMTAppSettings defaultSettings].testModeEnabled = self.testModeSwitch.isOn;
    self.txtAdSpace.enabled = self.txtPublisher.enabled = !self.testModeSwitch.isOn;
    
    if (self.testModeSwitch.isOn) {
        self.navigationItem.rightBarButtonItem = nil;
        
        [iSoma defaultAdSettings].publisherId = [SMTAppSettings defaultSettings].testAdPublisherID;
        [iSoma defaultAdSettings].adSpaceId = [SMTAppSettings defaultSettings].testAdSpaceID;
    } else {
        
        [iSoma defaultAdSettings].publisherId = [SMTAppSettings defaultSettings].adPublisherID;
        [iSoma defaultAdSettings].adSpaceId = [SMTAppSettings defaultSettings].adSpaceID;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onSave:)];
    }
    
    self.txtPublisher.text = [NSString stringWithFormat:@"%ld", (long)[iSoma defaultAdSettings].publisherId];
    self.txtAdSpace.text = [NSString stringWithFormat:@"%ld", (long)[iSoma defaultAdSettings].adSpaceId];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSave:(id)sender{
    NSString* publisher = self.txtPublisher.text;
    NSString* adSpace = self.txtAdSpace.text;
    [SMTAppSettings defaultSettings].adPublisherID = [publisher intValue];
    [SMTAppSettings defaultSettings].adSpaceID = [adSpace intValue];
    [iSoma setDefaultPublisherId:publisher adSpaceId:adSpace];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.txtPublisher becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [(SMTAppDelegate*)[UIApplication sharedApplication].delegate showLeftEdge];
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
