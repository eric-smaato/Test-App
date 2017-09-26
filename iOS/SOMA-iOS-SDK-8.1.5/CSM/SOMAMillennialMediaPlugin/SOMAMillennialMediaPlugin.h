//
//  SOMAMillennialMediaPlugin.h
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 12.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <iSoma/iSoma.h>
#import <MMAdSDK/MMAdSDK.h>

@interface SOMAMillennialMediaPlugin : SOMAMediationPlugin<MMInlineDelegate,MMInterstitialDelegate>
@property (nonatomic, strong) MMInlineAd *inlineAd;
@property (nonatomic, strong) MMInterstitialAd *interstitialAd;
@end
