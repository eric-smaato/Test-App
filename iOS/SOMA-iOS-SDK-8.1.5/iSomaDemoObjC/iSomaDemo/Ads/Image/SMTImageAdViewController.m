//
//  SMTImageAdViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTImageAdViewController.h"
#import <iSoma/iSoma.h>
#import "SMTAppSettings.h"

@interface SMTImageAdViewController ()<SOMAAdViewDelegate>
@end

@implementation SMTImageAdViewController
- (void)viewDidLoad{
    [super viewDidLoad];		
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
	return NO;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView*)adview{
	NSLog(@"Exited full screen");
}
- (void)somaAdViewWillHide:(SOMAAdView*)adview{
	NSLog(@"Ad view will hide");
}
@end
