//
//  SMTWelcomeViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 05/06/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTWelcomeViewController.h"
#import "SMTAppDelegate.h"

@interface SMTWelcomeViewController ()
@end

@implementation SMTWelcomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (BOOL)shouldAutorotate{
	return YES;
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

#pragma mark - IBActions
-(IBAction)onClose:(id)sender{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)onCloseAndDontShowAgain:(id)sender{
	[(SMTAppDelegate*)[UIApplication sharedApplication].delegate dontShowWelcomeMessageAgain];
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
