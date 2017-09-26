//
//  SOMAMoPubPlugin.h
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 06.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iSoma/iSoma.h>
#import "MPAdView.h"
#import "MPInterstitialAdController.h"

@interface SOMAMoPubPlugin : SOMAMediationPlugin<MPAdViewDelegate, MPInterstitialAdControllerDelegate>
@property (nonatomic) MPAdView *adView;
@property (nonatomic) MPInterstitialAdController *interstitial;
@end
