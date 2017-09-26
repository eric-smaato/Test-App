//
//  SMTCustomAdViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdViewController.h"

#import <iSoma/SOMAAdSettings.h>
#import "SMTCustomAdOptionsViewController.h"
#import "SMTCustomAdOptionTableManager.h"
#import "SMTCustomAdViewController+Debug.h"

/*---------------------------------------------------------------------------
 Optional: Implement SOMABannerViewDelegate to receive various callback
 ----------------------------------------------------------------------------*/
@interface SMTCustomAdViewController ()<SOMAAdViewDelegate>
@property(nonatomic, strong) SMTCustomAdOptionsViewController* optionsViewController;
@end

@implementation SMTCustomAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	
	self.navigationItem.backBarButtonItem.title = nil;
	// Add a button to show customization options
	UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
	[btn setImage:[UIImage imageNamed:@"95-equalizer"] forState:UIControlStateNormal];
	[btn addTarget:self
			action:@selector(showOptions:)
  forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
	
	self.bannerView.adSettings.formatStrict = YES;
	self.bannerView.adSettings.dimensionStrict = YES;
}


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self configureDebug];
	[self.bannerView load];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}


// method to show customizing options view
- (void)showOptions:(id)sender{
	UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"AdViewControllers" bundle:[NSBundle mainBundle]];
	self.optionsViewController = [storyBoard instantiateViewControllerWithIdentifier:@"smtCustomAdOptionsViewController"];
	self.optionsViewController.tableManager = [SMTCustomAdOptionTableManager createManager];
	
	self.optionsViewController.adView = self.bannerView;
	[self presentViewController:self.optionsViewController animated:YES completion:nil];
}

#pragma mark - SOMAAdViewDelegate
-(UIViewController *)somaRootViewController {
    return self;
}
- (void)somaAdViewWillLoadAd:(SOMAAdView *)adview{
	[self debugLog:@"Ad received, started rendering..."];
}
- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview{
	[self debugLog:@"Ad rendered, now showing..."];
}
- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error{
	[self debugLog:@"Failed to load ad"];
}
- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView *)adview{
	[self debugLog:@"Ad  clicked, entering fullscreen!"];
	return YES;
}
- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview{
	[self debugLog:@"Exit fullscreen"];
}
- (void)somaAdViewWillHide:(SOMAAdView *)adview{
	[self debugLog:@"Ad will hide now"];
}
@end
