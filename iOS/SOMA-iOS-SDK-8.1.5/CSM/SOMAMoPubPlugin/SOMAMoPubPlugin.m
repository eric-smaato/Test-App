//
//  SOMAMoPubPlugin.m
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 06.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "SOMAMoPubPlugin.h"
 

@implementation SOMAMoPubPlugin
- (instancetype)init{
    self = [super init];
    if (self) {
         
    }
    return self;
}

- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration *)network{
    self = [super initWithConfiguration:network];
    if (self) {
         
    }
    return self;
}

- (void)dealloc{
     
}

- (void)load {
	if (self.network.adunitid == nil) {
		[self adLoadFailedWithMessage:@"AdUnit value should be a JSON objet e.g. {\"adunitid\": \"24534e1901884e398f1253216226017e\"}"];
		return;
	}
	
	if (self.isInterstitial) {
		return [self loadInterstitial];
	}
	
	CGSize bannerSize = MOPUB_BANNER_SIZE;
	if (self.adDimension == SOMAAdDimensionMedRect) {
		bannerSize = MOPUB_MEDIUM_RECT_SIZE;
	} else if (self.adDimension == SOMAAdDimensionLeader){
		bannerSize = MOPUB_LEADERBOARD_SIZE;
	} else if (self.adDimension == SOMAAdDimensionSky){
		bannerSize = MOPUB_WIDE_SKYSCRAPER_SIZE;
	}
	
	self.adView = [[MPAdView alloc] initWithAdUnitId:self.network.adunitid
						size:bannerSize];
	self.adView.delegate = self;
	self.adView.frame = CGRectMake(0,
								   0,
								   bannerSize.width, bannerSize.height);
	[self.adView loadAd];
}

- (void)loadInterstitial{
	self.interstitial = [MPInterstitialAdController
						 interstitialAdControllerForAdUnitId:self.network.adunitid];
	self.interstitial.delegate = self;
	[self.interstitial loadAd];
}

- (void)presentInterstitial{
	if (self.interstitial.ready) {
		[self.interstitial showFromViewController:[self rootViewController]];
	} else {
		
	}
}

#pragma mark -
#pragma mark - <MPAdViewDelegate>
#pragma mark -
- (UIViewController *)viewControllerForPresentingModalView {
	return [super rootViewController];
}

- (void)adViewDidLoadAd:(MPAdView *)view{
	[self adLoadedWithView:view];
}
- (void)adViewDidFailToLoadAd:(MPAdView *)view{
	[self adLoadFailedWithError:[NSError errorWithDomain:@"com.soma.error" code:400 userInfo:nil]];
}
- (void)willPresentModalViewForAd:(MPAdView *)view{
	[self adWillPresentFullscreen];
}

- (void)didDismissModalViewForAd:(MPAdView *)view{
	[self adDidDismissFullscreen];
}

- (void)willLeaveApplicationFromAd:(MPAdView *)view{
	[self adWillLeaveApplication];
}


#pragma mark -
#pragma mark - <MPInterstitialAdControllerDelegate>
#pragma mark -
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial{
	[self adLoadedWithView:nil];
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial{
	[self adLoadFailedWithError:[NSError errorWithDomain:@"com.soma.error" code:400 userInfo:nil]];
}

- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial{
	[self adWillPresentFullscreen];
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial{
}

- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial{
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial{
	[self adDidDismissFullscreen];
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial{
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial{
    if ([self.delegate respondsToSelector:@selector(mediationPluginClicked:)]) {
        [self.delegate mediationPluginClicked:self];
    }
}


@end
