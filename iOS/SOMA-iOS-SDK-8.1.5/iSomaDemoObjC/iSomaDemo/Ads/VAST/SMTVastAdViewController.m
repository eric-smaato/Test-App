//
//  SMTVastAdViewController.m
//  iSomaInternalDemo
//
//  Created by Aman Shaikh on 12/02/15.
//  Copyright (c) 2015 Smaato Inc. All rights reserved.
//

#import "SMTVastAdViewController.h"

@interface SMTVastAdViewController ()<SOMAAdViewDelegate>

@end

@implementation SMTVastAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	SOMAInterstitialVideoAdView* adview = [[SOMAInterstitialVideoAdView alloc] init];
	self.adView = adview;
	self.adView.delegate = self;

	self.adView.adSettings.autoReloadEnabled = NO;
	self.showFullScreenButton.hidden = YES;
}

#pragma mark - IBActions
- (IBAction)onLoadAd:(id)sender{
	dispatch_async(dispatch_get_main_queue(), ^{
		self.showFullScreenButton.hidden = YES;
		self.loadAdButton.enabled = NO;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.adView load];
		});
	});
	
}

- (IBAction)onShowAd:(id)sender{
	if (self.adView.isLoaded) {
		[self.adView show];
	}
}

#pragma mark -
#pragma mark - SOMAAdViewDelegate
#pragma mark -

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView*)adview{
	NSLog(@"Ad View Will Load");
}

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
	NSLog(@"Ad View Loaded");
	
	[self.loadAdButton setTitle:@"Ad loaded!" forState:UIControlStateDisabled];
	self.showFullScreenButton.hidden = NO;
}

- (void)somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
	BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
	int reloadInterval = adview.adSettings.autoReloadInterval;
	NSString* reloadTimeMessage = @"";
	if (reloadEnabled) {
		reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
	}
	NSLog(@"AdView failed to load: %@", [error localizedDescription]);
	
	self.loadAdButton.enabled = YES;
	[self.loadAdButton setTitle:@"Failed to load, retry" forState:UIControlStateNormal];
	self.showFullScreenButton.hidden = YES;
}

- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView*)adview{
	NSLog(@"Ad Clicked, will go fullscreen");
	return YES;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView*)adview{
	NSLog(@"Exited full screen");
}
- (void)somaAdViewWillHide:(SOMAAdView*)adview{
	NSLog(@"Ad view will hide");
	self.loadAdButton.enabled = YES;
	self.showFullScreenButton.hidden = YES;
	[self.loadAdButton setTitle:@"Reload Ad" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
