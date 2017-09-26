//
//  SOMAIAdMediationPlugin.m
//  iSoma
//
//  Created by Aman Shaikh on 09.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "SOMAIAdMediationPlugin.h"

@implementation SOMAIAdMediationPlugin


- (void)load{
	if (self.isInterstitial) {
		[self loadInterstitial];
		return;
	}
	
	ADAdType type = (self.adDimension == SOMAAdDimensionMedRect) ? ADAdTypeMediumRectangle : ADAdTypeBanner;
	
	ADBannerView* banner = [[ADBannerView alloc] initWithAdType:type];
	banner.delegate = self;
	self.bannerView = banner;
}

- (void)dealloc{
	
}

- (void)loadInterstitial{
	if(self.interStitial != nil){
		self.interstitialViewController.plugin = nil;
		self.interstitialViewController = nil;
		self.interStitial.delegate = nil;
		self.interStitial = nil;
	}
	
	self.interstitialViewController = [[SOMAIADInterstitialViewController alloc] init];
	self.interstitialViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	self.interstitialViewController.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
	self.interstitialViewController.plugin = self;
	self.interStitial = [[ADInterstitialAd alloc] init];
	self.interStitial.delegate = self.interstitialViewController;
	
	self.isPresented = NO;
}

- (void)presentInterstitial{
	self.isPresented = YES;
	[self.interStitial presentInView:self.interstitialViewController.view];
	[UIViewController prepareInterstitialAds];
	[[self rootViewController] presentViewController:self.interstitialViewController animated:true completion:^{
	}];
}

- (void)adDidDismissFullscreen{
	self.isPresented = NO;
	[super adDidDismissFullscreen];
}

#pragma mark - ADBannerViewDelegate
#pragma mark -
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
	self.isPresented = NO;
	[self adLoadedWithView:banner];
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
	self.isPresented = NO;
	[self adLoadFailedWithError:error];
}
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
	[self adWillPresentFullscreen];
	self.isPresented = YES;
	
	if (willLeave) {
		[self adWillLeaveApplication];
	}
		
	return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner{
	self.isPresented = NO;
	[self adDidDismissFullscreen];
}


@end
