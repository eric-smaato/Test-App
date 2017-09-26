//
//  SOMAIAdMediationPlugin.h
//  iSoma
//
//  Created by Aman Shaikh on 09.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <iSoma/iSoma.h>
#import <iAd/iAd.h>
#import "SOMAIADInterstitialViewController.h"

@interface SOMAIAdMediationPlugin : SOMAMediationPlugin<ADBannerViewDelegate, ADInterstitialAdDelegate>
@property ADBannerView* bannerView;
@property ADInterstitialAd* interStitial;
@property SOMAIADInterstitialViewController* interstitialViewController;
@end
