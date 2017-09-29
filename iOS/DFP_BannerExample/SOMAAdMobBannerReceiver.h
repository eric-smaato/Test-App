//
//  SOMAAdMobBannerReceiver.h
//  AdMob+SOMA
//
//  Created by Bilge Ulusoy on 01.06.12.
//  Copyright (c) 2012 Smaato Inc. All rights reserved.
//

// Updated by Shaikh Aman
#import <GoogleMobileAds/GoogleMobileAds.h>
//#import "GADCustomEventBanner.h"
//#import "GADCustomEventBannerDelegate.h"
#import <iSoma/iSoma.h>

@protocol GADCustomEventBanner;

@interface SOMAAdMobBannerReceiver : NSObject <GADCustomEventBanner,SOMAAdViewDelegate>
@property (nonatomic, assign) id delegate;

@end
