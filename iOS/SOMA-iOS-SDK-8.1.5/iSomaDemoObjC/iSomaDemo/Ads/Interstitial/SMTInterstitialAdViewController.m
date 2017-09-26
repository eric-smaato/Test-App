//
//  SMTInterstitialAdViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTInterstitialAdViewController.h"
#import "SMTAppSettings.h"
#import <UIKit/UIKit.h>

@interface SMTInterstitialAdViewController()<SOMAAdViewDelegate>
@end

@implementation SMTInterstitialAdViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	self.adView= [[SOMAInterstitialAdView alloc] init];	
	self.adView.delegate = self;
	
//	self.adView.adSettings.publisherId = 0;// your publisher id
//	self.adView.adSettings.adSpaceId = 0;// your adspace id
	
	// configure other ad settings if wanted
	// ...
	//
	
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

@end
