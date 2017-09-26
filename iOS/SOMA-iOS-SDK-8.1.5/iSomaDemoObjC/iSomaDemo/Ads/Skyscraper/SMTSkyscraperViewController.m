//
//  SMTSkyscraperViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 11/06/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTSkyscraperViewController.h"
#import "SMTAppSettings.h"

@interface SMTSkyscraperViewController ()<SOMAAdViewDelegate>

@end

@implementation SMTSkyscraperViewController
- (void)viewDidLoad{
	[super viewDidLoad];
}

#pragma mark -
#pragma mark - SOMAAdViewDelegate
#pragma mark -

- (UIViewController *)somaRootViewController{
    return self;
}
- (void)somaAdViewWillLoadAd:(SOMAAdView*)adview{
	NSLog(@"Ad View Will Load");
}

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
	NSLog(@"Ad View Loaded");
}

- (void)somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
	BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
	int reloadInterval = adview.adSettings.autoReloadInterval;
	NSString* reloadTimeMessage = @"";
	if (reloadEnabled) {
		reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
	}
	NSLog(@"AdView failed to load: %@", [error localizedDescription]);
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
}
@end
