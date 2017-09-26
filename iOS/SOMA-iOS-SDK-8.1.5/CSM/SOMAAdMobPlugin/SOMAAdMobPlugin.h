//
//  SOMAAdMobPlugin.h
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 25.09.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <iSoma/iSoma.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface SOMAAdMobPlugin : SOMAMediationPlugin<GADBannerViewDelegate, GADInterstitialDelegate>
@property GADBannerView* bannerView;
@property GADInterstitial* interstitial;
@end
