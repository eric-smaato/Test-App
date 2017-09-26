//
//  SOMAAdMobInterstitialReceiver.m
//  SmaatoShowcase
//
//  Created by Aman Shaikh on 09/10/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SOMAAdMobInterstitialReceiver.h"

@implementation SOMAAdMobInterstitialReceiver

- (void)presentFromRootViewController:(UIViewController *)rootViewController{
	self.adview.rootViewController = rootViewController;
	[self.adview show];
}
- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request{
	// Parse Adspace & Publisher ID
	NSMutableDictionary *adServerParameter = [[NSMutableDictionary alloc] init];
	NSArray *chunks = [[serverParameter lowercaseString] componentsSeparatedByString: @"&"];
	
	for (NSString *component in chunks) {
		NSArray *pair = [component componentsSeparatedByString:@"="];
		
		[adServerParameter setObject:[[pair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding: NSMacOSRomanStringEncoding]
							  forKey:[pair objectAtIndex:0]];
	}
	
	// Create a SOMABannerView and apply adspace & publisher settings
	if (self.adview == nil) {
		self.adview = [[SOMAInterstitialAdView alloc] init];
	}
	
	[self.adview adSettings].type = SOMAAdTypeAll;
//	self.adview.adSettings.httpsOnly = SOMAHttpsOnlyYes;
	[self.adview adSettings].adSpaceId = [[adServerParameter objectForKey:@"adspace"] intValue];
	[self.adview adSettings].publisherId = [[adServerParameter objectForKey:@"publisher"] intValue];
    
    if ([[adServerParameter allKeys] containsObject:@"pub"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"pub"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisher"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"publisher"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisherid"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"publisherid"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisherId"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"publisherId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"PublisherId"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"PublisherId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"PublisherID"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"PublisherID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisherID"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"publisherID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"Publisher"]) {
       self.adview.adSettings.publisherId=[adServerParameter[@"Publisher"] intValue];
    }
    
    if ([[adServerParameter allKeys] containsObject:@"ad"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"ad"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspace"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"adspace"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspaceid"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"adspaceid"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspaceId"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"adspaceId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdspaceId"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"AdspaceId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdspaceID"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"AdspaceID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspaceID"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"adspaceID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdSpaceID"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"AdSpaceID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdSpaceId"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"AdSpaceId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdSpace"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"AdSpace"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"Ad"]) {
       self.adview.adSettings.adSpaceId=[adServerParameter[@"Ad"] intValue];
    }
    
	self.adview.delegate = self;
	
	// UPDATE LOCATION
	//self.somaBanner.adSettings.longitude = LONGITUDE;
	//self.somaBanner.adSettings.latitude = LATITUDE;
	
	/*************************************
	 Set user targetting parameters
	 *************************************/
	// UNCOMMENT THE FOLLOWING LINE FIRST
//	SOMAUserProfile* profile = self.adview.adSettings.userProfile;
	
	/*
	 Set age
	 */
	//	 profile.age = 30; // integer value
	
	/*
	 Set Gender: Possible values:
	 ----------------------------
	 SOMAUserGenderUnknown,
	 SOMAUserGenderMale,
	 SOMAUserGenderFemale
	 */
	//	 profile.gender = SOMAUserGenderMale;
	
	/*
	 Set Date of Birth: NSString
	 ----------------------------
	 Date with YYYYMMDD format e.g. @"19550224" for February 24, 1955
	 */
	//	 profile.dateOfBirthYYYYMMDD = @"19550224";
	
	/*
	 Set Yearly income: Possible values:
	 ----------------------------
	 SOMAUserYearlyIncomeUnknown,
	 SOMAUserYearlyIncomeLessThan15K,
	 SOMAUserYearlyIncome15to24K,
	 SOMAUserYearlyIncome25to39K,
	 SOMAUserYearlyIncome40to59K,
	 SOMAUserYearlyIncome60to74K,
	 SOMAUserYearlyIncome75to99K,
	 SOMAUserYearlyIncome100kPlus
	 */
	//	 profile.yearlyIncome = SOMAUserYearlyIncome100kPlus;
	
	/*
	 Set ethnicity: Possible values:
	 ----------------------------
	 SOMAUserEthnicityUnknown,
	 SOMAUserEthnicityWhite,
	 SOMAUserEthnicityMiddleEastern,
	 SOMAUserEthnicityBlack,
	 SOMAUserEthnicityLatino,
	 SOMAUserEthnicitySouthAsian,
	 SOMAUserEthnicityOriental,
	 SOMAUserEthnicityOther
	 */
	//	profile.ethnicity = SOMAUserEthnicityBlack;
	
	/*
	 Set education: Possible values:
	 ----------------------------
	 SOMAUserEducationUnknown=0,
	 SOMAUserEducationLessThanSecondary,
	 SOMAUserEducationSecondary,
	 SOMAUserEducationUniversity,
	 SOMAUserEducationAdvanced
	 */
	//	profile.education = SOMAUserEducationAdvanced;
	
	/*
	 Set interest: Possible values:
	 ----------------------------
	 SOMAUserGenderInterestUnknown = 0,
	 SOMAUserGenderInterestBoth,
	 SOMAUserGenderInterestMale,
	 SOMAUserGenderInterestFemale
	 */
	//	profile.interestedIn = SOMAUserGenderInterestBoth;
	
	/*
	 Set marital status: Possible values:
	 ----------------------------
	 SOMAUserMaritalStatusUnknown=0,
	 SOMAUserMaritalStatusSingle,
	 SOMAUserMaritalStatusMarried,
	 SOMAUserMaritalStatusDivorced
	 */
	//	profile.maritalStatus = SOMAUserMaritalStatusMarried;
	
	/*
	 Set country: Any String value.
	 */
	//	profile.country = @"Country";
	
	/*
	 Set country code: Any String value.
	 */
	//	profile.countryCode = @"countryCode";
	
	/*
	 Set region: Any String value.
	 */
	//	profile.region = @"region";
	
	/*
	 Set City: Any String value.
	 */
	//	profile.city = @"city";
	
	/*
	 Set zip code: Any String value.
	 */
	//	profile.zip = @"zip";
	
	////////// END TARGETTING ////////////////////////
	
	[self.adview load];
}


#pragma mark - SOMABannerViewDelegate
- (UIViewController*)somaRootViewController{
	return nil;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView *)adview{
}

- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(customEventInterstitialDidReceiveAd:)]) {
        [self.delegate customEventInterstitialDidReceiveAd:self];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(customEventInterstitial:didFailAd:)]) {
        [self.delegate customEventInterstitial:self didFailAd:error];
    }
}

- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(customEventInterstitialWillLeaveApplication:)]) {
        [self.delegate customEventInterstitialWillLeaveApplication:self];
    }
	return YES;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(customEventInterstitialWillDismiss:)]) {
        [self.delegate customEventInterstitialWillDismiss:self];
    }
	self.adview = nil;
}
@end
