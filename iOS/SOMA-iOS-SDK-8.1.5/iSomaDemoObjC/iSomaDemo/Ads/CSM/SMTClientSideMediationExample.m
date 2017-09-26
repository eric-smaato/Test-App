//
//  SMTClientSideMediationExample.m
//  iSomaDemoObjc
//
//  Created by Aman Shaikh on 29.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "SMTClientSideMediationExample.h"
#import <iSoma/iSoma.h>

@interface SMTClientSideMediationExample ()<SOMAAdViewDelegate>
@property SOMAAdView* banner;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIButton *loadInterstitialButton;
@property (weak, nonatomic) IBOutlet UIButton *showInterstitialButton;
@property SOMAInterstitialAdView* interstitialAd;
@property NSArray* networks;
@end

@implementation SMTClientSideMediationExample

- (void)viewDidLoad {
    [super viewDidLoad];
	self.showInterstitialButton.enabled = NO;
}
- (void)createAd{
	
	CGRect adFrame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ?
	CGRectMake(0, 20, 728, 90) : CGRectMake(0, 20, 320, 50);
	
	adFrame.origin.x = (self.view.bounds.size.width - adFrame.size.width)/2;
	
	SOMAAdView *adView =
	[[SOMAAdView alloc] initWithFrame:adFrame];
	
	adView.delegate = self;
	
	//	adView.adSettings.publisherId = 1001000088;
	//	adView.adSettings.adSpaceId = 101003650;
	
	adView.adSettings.publisherId = 1001000033;
	adView.adSettings.adSpaceId = 130056835;
	
	adView.adSettings.userProfile.age = 30;
	adView.shouldAppearAutomatically = YES;
	
	// Send location
	double latitude = 90;
	double longitude = 100;
	
	adView.adSettings.latitude = latitude;
	adView.adSettings.longitude = longitude;
	adView.adSettings.userProfile.ethnicity = SOMAUserEthnicityMiddleEastern;
	adView.adSettings.userProfile.maritalStatus = SOMAUserMaritalStatusSingle;
	
	// Remaining adView settings
	adView.adSettings.userProfile.gender = SOMAUserGenderFemale;
	adView.adSettings.userProfile.interestedIn = SOMAUserGenderInterestFemale;
	adView.adSettings.type = SOMAAdTypeImage;
	adView.adSettings.dimension = SOMAAdDimensionXXLARGE;
	
	//	adView.adSettings.autoReloadEnabled = NO;
	adView.adSettings.autoReloadInterval  = 10;
	[self.view addSubview:adView];
	[adView load];
	
}
#pragma mark -
#pragma mark - IBAction
#pragma mark -
- (IBAction)onLoadInterstitial:(UIButton *)sender {
	if (self.interstitialAd == nil) {
		self.interstitialAd = [SOMAInterstitialAdView new];
		self.interstitialAd.adSettings.publisherId = 1001000033;
		self.interstitialAd.adSettings.adSpaceId = 130056836;
		self.interstitialAd.delegate = self;
	}
	[self.interstitialAd load];
}

- (IBAction)onShowInterstitial:(id)sender {
	[self.interstitialAd show];
	self.showInterstitialButton.enabled = false;
}

- (IBAction)onAdReload:(id)sender {
	self.reloadButton.enabled = NO;
	if (self.banner == nil ) {
		[self createAd];
		
	} else {
		[self.banner load];
	}
}

#pragma mark -
#pragma mark - SOMAAdViewDelegate
#pragma mark -

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView*)adview{
	NSLog(@"PUBLISHER> Ad View Will Load");
	
}

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
	NSLog(@"PUBLISHER> Ad View Loaded");
	if (self.interstitialAd == adview) {
		self.showInterstitialButton.enabled = YES;
	} else {
		if (self.banner == nil) {
			self.banner = adview;
		}
		self.reloadButton.enabled = YES;
	}
}

- (void)somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
	if (self.interstitialAd == adview) {
		if (self.interstitialAd.isNewAdAvailable  == false || self.interstitialAd.isAdShown == true) {
			self.showInterstitialButton.enabled = NO;
		}
	} else {
		if (self.banner == nil) {
			self.banner = adview;
		}
		self.reloadButton.enabled = YES;
	}
	BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
	int reloadInterval = adview.adSettings.autoReloadInterval;
	NSString* reloadTimeMessage = @"";
	if (reloadEnabled) {
		reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
	}
	NSLog(@"AdView failed to load: %@", [error localizedDescription]);
}

- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView*)adview{
	NSLog(@"PUBLISHER> Ad Clicked, will go fullscreen");
	return YES;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView*)adview{
	NSLog(@"PUBLISHER> Exited full screen");
}

- (void)somaAdViewWillHide:(SOMAAdView*)adview{
	NSLog(@"PUBLISHER> Ad view will hide");
}


// these are optional methods, just to investigate CSM
- (void)somaAdView:(SOMAAdView *)adview didReceivedMediationResponse:(NSArray *)networks{
	self.networks = networks;
	NSLog(@"%@", networks);
}

- (void)somaAdView:(SOMAAdView *)adview csm:(SOMAMediatedNetworkConfiguration *)network status:(NSString *)status {
	for (SOMAMediatedNetworkConfiguration* tmp in self.networks) {
		if (tmp == network) {
			tmp.status = status;
			NSLog(@"%@ -> %@",tmp.networkName, tmp.status);
		}
	}
}


@end
