//
//  MyCustomPlugin.m
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 12.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "MyCustomPlugin.h"
@implementation MyCustomPlugin

- (instancetype)init{
    self = [super init];
    if (self) {
         
    }
    return self;
}
- (void)myLoadMethod:(id)data{
	self.network.adunitid  = data[@"id"];
	if (self.network.adunitid == nil) {
		[self adLoadFailedWithMessage:@"AdUnit value should be a JSON objet e.g. {\"adunitid\": \"ca-app-pub-3940256099942544/6300978111\"}"];
		return;
	}
	
	
	if (self.isInterstitial) {
		[self loadInterstitial];
		return;
	}
	
	GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeFromCGSize(CGSizeMake(self.somaBannerSize.width, self.somaBannerSize.height))];
	bannerView.delegate = self;
	bannerView.rootViewController = [super rootViewController];
	self.bannerView = bannerView;
	self.bannerView.adUnitID = self.network.adunitid;
	GADRequest* request = [GADRequest request];
	request.testDevices = @[ kGADSimulatorID ];
	[self.bannerView loadRequest:request];
}
- (void)dealloc{
     
}

- (void)loadInterstitial{
	self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:self.network.adunitid];
	self.interstitial.delegate = self;
	
	
	GADRequest* request = [GADRequest request];
	request.testDevices = @[ kGADSimulatorID ];
	[self.interstitial loadRequest:request];
}

- (void)presentInterstitial{
	[self.interstitial presentFromRootViewController:self.rootViewController];
}


#pragma mark -
#pragma mark - GADBannerViewDelegate
#pragma mark -
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
	[self adLoadedWithView:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
	[self adLoadFailedWithError:error];
}


- (void)adViewDidDismissScreen:(GADBannerView *)bannerView{
	[self adDidDismissFullscreen];
}

- (void)adViewWillLeaveApplication:(GADBannerView *)bannerView{
	[self adWillPresentFullscreen];
}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView{
	[self adWillPresentFullscreen];
}

#pragma mark -
#pragma mark - GADInterstitialDelegate
#pragma mark -

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad{
	[self adLoadedWithView:nil];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error{
	[self adLoadFailedWithError:error];
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad{
	[self adWillPresentFullscreen];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad{
	[self adDidDismissFullscreen];
}
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad{
	[self adWillPresentFullscreen];
    if ([self.delegate respondsToSelector:@selector(mediationPluginClicked:)]) {
        [self.delegate mediationPluginClicked:self];
    }
}

@end
