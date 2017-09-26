//
//  MyCustomPlugin.h
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 12.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <iSoma/iSoma.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface MyCustomPlugin : SOMAMediationPlugin<GADBannerViewDelegate, GADInterstitialDelegate>
@property GADBannerView* bannerView;
@property GADInterstitial* interstitial;
- (void)myLoadMethod:(id)data;
@end
