//
//  SMTRootViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 19/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTRootViewController.h"

@interface SMTRootViewController ()

@end

@implementation SMTRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	[self setNeedsStatusBarAppearanceUpdate];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    self.contentViewScaleValue = 0.9;
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    id obj = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuController"];
    self.leftMenuViewController = obj;
}

- (IBAction)onShowMenu:(id)sender{
    [self presentLeftMenuViewController];
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
