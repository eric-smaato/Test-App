//
//  SOMAAdMobBannerReceiver.m
//  AdmobDemo
//
//  Created by Bilge Ulusoy on 01.06.12.
//  Copyright (c) 2012 Smaato Inc. All rights reserved.
//

// Updated by Shaikh Aman

#import "SOMAAdMobBannerReceiver.h"
static NSString *const customEventErrorDomain = @"com.google.CustomEvent";
@interface SOMAAdMobBannerReceiver()
@property(nonatomic, strong) SOMAAdView* somaBanner;
@end

@implementation SOMAAdMobBannerReceiver

@synthesize delegate = delegate_;

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request  {
	
	
    SOMAAdDimension dimension;
    
    // Determine Correct SOMAAdDimension for our Ad :)
    if (CGSizeEqualToSize(CGSizeFromGADAdSize(adSize), CGSizeFromGADAdSize(kGADAdSizeBanner))) {
        dimension = SOMAAdDimensionDefault;
    } else if (CGSizeEqualToSize(CGSizeFromGADAdSize(adSize), CGSizeFromGADAdSize(kGADAdSizeMediumRectangle))) {
        dimension = SOMAAdDimensionMedRect;
    } else if (CGSizeEqualToSize(CGSizeFromGADAdSize(adSize), CGSizeFromGADAdSize(kGADAdSizeLeaderboard))) {
        dimension = SOMAAdDimensionLeader;
    } else if (CGSizeEqualToSize(CGSizeFromGADAdSize(adSize), CGSizeFromGADAdSize(kGADAdSizeSkyscraper))) {
        dimension = SOMAAdDimensionSky;
    } else {
        dimension = SOMAAdDimensionDefault;
    }
    
    // Parse Adspace & Publisher ID
    NSMutableDictionary *adServerParameter = [[NSMutableDictionary alloc] init];
    NSArray *chunks = [[serverParameter lowercaseString] componentsSeparatedByString: @"&"];
    
    for (NSString *component in chunks) {
        NSArray *pair = [component componentsSeparatedByString:@"="];
        
        [adServerParameter setObject:[[pair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding: NSMacOSRomanStringEncoding]
                        forKey:[pair objectAtIndex:0]]; 
    }
    
    // Create a SOMABannerView and apply adspace & publisher settings
    if (self.somaBanner == nil) {		
        self.somaBanner = [[SOMAAdView alloc] init];
		CGRect rect = CGRectZero;
		rect.size = CGSizeFromGADAdSize(adSize);
		self.somaBanner.frame = rect;
	}
	
	[self.somaBanner adSettings].type = SOMAAdTypeAll;
//	self.somaBanner.adSettings.httpsOnly = SOMAHttpsOnlyYes;
	[self.somaBanner adSettings].dimension = dimension;
    [self.somaBanner adSettings].adSpaceId = [[adServerParameter objectForKey:@"adspace"] intValue];
    [self.somaBanner adSettings].publisherId = [[adServerParameter objectForKey:@"publisher"] intValue];
    
    if ([[adServerParameter allKeys] containsObject:@"pub"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"pub"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisher"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"publisher"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisherid"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"publisherid"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisherId"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"publisherId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"PublisherId"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"PublisherId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"PublisherID"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"PublisherID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"publisherID"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"publisherID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"Publisher"]) {
        self.somaBanner.adSettings.publisherId=[adServerParameter[@"Publisher"] intValue];
    }
    
    if ([[adServerParameter allKeys] containsObject:@"ad"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"ad"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspace"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"adspace"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspaceid"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"adspaceid"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspaceId"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"adspaceId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdspaceId"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"AdspaceId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdspaceID"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"AdspaceID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"adspaceID"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"adspaceID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdSpaceID"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"AdSpaceID"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdSpaceId"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"AdSpaceId"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"AdSpace"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"AdSpace"] intValue];
    } else if ([[adServerParameter allKeys] containsObject:@"Ad"]) {
        self.somaBanner.adSettings.adSpaceId=[adServerParameter[@"Ad"] intValue];
    }
    
	self.somaBanner.adSettings.autoReloadEnabled = NO;
    self.somaBanner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	self.somaBanner.delegate  = self;
	
	
	
	// UPDATE LOCATION
	//self.somaBanner.adSettings.longitude = LONGITUDE;
	//self.somaBanner.adSettings.latitude = LATITUDE;
	
	/*************************************
	 Set user targetting parameters
	 *************************************/
	// UNCOMMENT THE FOLLOWING LINE FIRST
//		SOMAUserProfile* profile = self.somaBanner.adSettings.userProfile;
	
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
	[self.somaBanner load];
	
	adServerParameter = nil;
}

#pragma mark - SOMABannerViewDelegate
- (UIViewController*)somaRootViewController{
	return nil;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView *)adview{
}

- (void)somaAdViewDidLoadAd:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(customEventBanner:didReceiveAd:)]) {
        [self.delegate customEventBanner:self didReceiveAd:adview];
    }
}

- (void)somaAdView:(SOMAAdView *)adview didFailToReceiveAdWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(customEventBanner:didFailAd:)]) {
        error = [NSError errorWithDomain:customEventErrorDomain
                                    code:error.code
                                userInfo:nil];
        [self.delegate customEventBanner:self didFailAd:error];
    }
}

- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(customEventBannerWillPresentModal:)]) {
        [self.delegate customEventBannerWillPresentModal:self];
    }
	return YES;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView *)adview{
    if ([self.delegate respondsToSelector:@selector(customEventBannerDidDismissModal:)]) {
        [self.delegate customEventBannerDidDismissModal:self];
    }
}

- (void)dealloc {
	NSLog(@"Deallocated!!");
}

@end
