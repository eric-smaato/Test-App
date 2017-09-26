//
//  SOMAAdMobInterstitialReceiver.h
//  SmaatoShowcase
//
//  Created by Aman Shaikh on 09/10/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GoogleMobileAds/GoogleMobileAds.h>
#import <iSoma/iSoma.h>

@interface SOMAAdMobInterstitialReceiver : NSObject< GADCustomEventInterstitial, SOMAAdViewDelegate>
@property SOMAAdView* adview;
@property (nonatomic, assign) id<GADCustomEventInterstitialDelegate> delegate;
@end
