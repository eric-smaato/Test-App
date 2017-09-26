//
//  SOMAMillennialMediaPlugin.m
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 12.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "SOMAMillennialMediaPlugin.h"
 

@implementation SOMAMillennialMediaPlugin

- (instancetype)initWithConfiguration:(SOMAMediatedNetworkConfiguration *)network{
    self = [super initWithConfiguration:network];
    if (self) {
         
    }
    return self;
}

- (void)dealloc{
     
}

- (void)load{
    if(!([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedDescending)) {
        NSError *error = [NSError errorWithDomain:@"SOMAMillennialMediaPlugin" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"iOS 7.0 and higher supported"}];
        [self adLoadFailedWithError:error];
        return;
    }
    
    if (self.network.adunitid == nil) {
        [self adLoadFailedWithMessage:@"AdUnit value should be a JSON objet e.g. {\"adunitid\": \"ca-app-pub-3940256099942544/6300978111\"}"];
        return;
    }

    NSString* adUnitId = self.network.adunitid;
    NSString* siteId = nil;
    
    NSArray *adUnitSplited = [self.network.adunitid componentsSeparatedByString:@";"];
    if([adUnitSplited count] > 1){
        adUnitId = adUnitSplited[0];
        siteId = adUnitSplited[1];
    }
    
    MMAppSettings* appSettings = [[MMAppSettings alloc] init];
    appSettings.mediator = @"Smaato";
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        if (siteId!=nil) {
          appSettings.siteId = siteId;
        }
        [MMSDK setLogLevel:MMLogLevelDebug];
        [[MMSDK sharedInstance] initializeWithSettings:appSettings withUserSettings:nil];
    });

    if (self.isInterstitial) {
        [self loadInterstitial];
        return;
    }
    
    MMInlineAdSize adSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? MMInlineAdSizeBanner :MMInlineAdSizeLeaderboard;
    if (self.adDimension == SOMAAdDimensionMedRect) {
        adSize = MMInlineAdSizeMediumRectangle;
    }
    
    self.inlineAd = [[MMInlineAd alloc] initWithPlacementId:adUnitId adSize:adSize];
    self.inlineAd.delegate = self;
    [self.inlineAd request:nil];
}

- (void)loadInterstitial{
    NSString* adUnitId = self.network.adunitid;
    
    NSArray *adUnitSplited = [self.network.adunitid componentsSeparatedByString:@";"];
    if([adUnitSplited count] > 1){
        adUnitId = adUnitSplited[0];
    }

    self.interstitialAd = [[MMInterstitialAd alloc] initWithPlacementId:adUnitId];
    self.interstitialAd.delegate = self;
    self.interstitialAd.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.interstitialAd load:nil];
}

- (void)presentInterstitial{
    [self.interstitialAd showFromViewController:[self rootViewController]];
}



#pragma mark -
#pragma mark - MMInlineDelegate
#pragma mark -
- (void)inlineAdRequestDidSucceed:(MMInlineAd *)ad {
	[self adLoadedWithView:ad.view];
}

- (void)inlineAd:(MMInlineAd *)ad requestDidFailWithError:(NSError *)error {
	[self adLoadFailedWithError:error];
}

- (void)inlineAd:(MMInlineAd *)ad willResizeTo:(CGRect)frame isClosing:(BOOL)isClosingResize {
	NSLog(@"Inline ad is %@ and will resize to frame %@.", isClosingResize ? @"closing" : @"resizing", NSStringFromCGRect(frame));
}

- (void)inlineAd:(MMInlineAd *)ad didResizeTo:(CGRect)frame isClosing:(BOOL)isClosingResize {
	NSLog(@"Inline ad is %@ and did resize to frame %@.", isClosingResize ? @"closing" : @"resizing", NSStringFromCGRect(frame));
}

- (void)inlineAdWillPresentModal:(MMInlineAd *)ad {
	[self adWillPresentFullscreen];
}

- (void)inlineAdDidCloseModal:(MMInlineAd *)ad {
	[self adDidDismissFullscreen];
}

- (void)inlineAdWillLeaveApplication:(MMInlineAd *)ad {
	[self adWillLeaveApplication];
}

- (UIViewController *)viewControllerForPresentingModalView {
	return [self rootViewController];
}

#pragma mark -
#pragma mark - Interstitial Delegate
#pragma mark -
- (void)interstitialAdLoadDidSucceed:(MMInterstitialAd *)ad {
	[self adLoadedWithView:nil];
}

- (void)interstitialAd:(MMInterstitialAd *)ad loadDidFailWithError:(NSError *)error {
	[self adLoadFailedWithError:error];
}

- (void)interstitialAdWillDisplay:(MMInterstitialAd *)ad {
	[self adWillPresentFullscreen];
}

- (void)interstitialAd:(MMInterstitialAd *)ad showDidFailWithError:(NSError *)error {
    [self adLoadFailedWithError:error];
}

- (void)interstitialAdDidDismiss:(MMInterstitialAd *)ad {
	[self adDidDismissFullscreen];
}

- (void)interstitialAdTapped:(MMInterstitialAd *)ad {
    if ([self.delegate respondsToSelector:@selector(mediationPluginClicked:)]) {
        [self.delegate mediationPluginClicked:self];
    }
}

- (void)interstitialAdWillLeaveApplication:(MMInterstitialAd *)ad {
	[self adWillLeaveApplication];
}

- (void)interstitialAdDidExpire:(MMInterstitialAd *)ad {
    [self.interstitialAd load:nil];
}
@end
