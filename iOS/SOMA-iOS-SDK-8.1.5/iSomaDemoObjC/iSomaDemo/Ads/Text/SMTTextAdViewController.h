//
//  SMTTextAdViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
/*====================================
 
		iSoma Text Ad Demo
 --------------------------------------
 
 1. In Interface Builder add a UIView of size 320x50;
 2. Select the view and open Identity Inspector (CMD+OPT+3)
 3. Set class `SOMABannerTextAdView`
 4. Add the following User Defined Runtime Attributes:
	4.1. Key Path: publisherId, Type: NSNumber, Value: [YOUR PUBLISHER ID]
	4.2. Key Path: adSpaceId,   Type: NSNumber, Value: [YOUR AD SPACE ID]
 
NOTE: To show all kind of ads, set class `SOMAAdView`
 
OPTIONAL:
 1. If you like to handle ad events
	1.1. Implement SOMAAdViewDelegate protocol in the view controller
	1.2. Interface Builder connect to view controller to the delegate property of the ad view.
 
 2. If you like to update ad settings of this particular ad:
	2.1. import <iSoma/iSoma.h> in the header
	2.2. Declare an IBOutlet as @property(nonatomic, weak) SOMAAdView* adView;
	2.3. With Interface Builder, connect the Ad view to the outlet.
	2.4. in viewDidLoad method updat the settings as:
			self.adView.adSettings.adSpaceId=@"YOUR_AD_SPACE_ID";
 
 3. You can set global publisher id and ad space id
	in `applicationDidFinishLaunching` method as:
 
	[iSoma setGlobalPublisherId:YOUR_PUB_ID adSpaceId:YOUR_ADSPACE_ID];

USER PROFILE:
	You can set user profile to individual ad or globally by updating adView.adSettings.userProfile
	or [iSoma userProfile] respectively.
	
	Following is the configuration options for user profile:
		1. age: Integer value
		2. gender:
			SOMAUserGenderFemale
			SOMAUserGenderMale
		3. yearlyIncome:
			 SOMAUserYearlyIncomeLessThan15K,
			 SOMAUserYearlyIncome15to24K,
			 SOMAUserYearlyIncome25to39K,
			 SOMAUserYearlyIncome40to59K,
			 SOMAUserYearlyIncome60to74K,
			 SOMAUserYearlyIncome75to99K,
			 SOMAUserYearlyIncome100kPlus
		4. ethnicity:
			 SOMAUserEthnicityWhite,
			 SOMAUserEthnicityMiddleEastern,
			 SOMAUserEthnicityBlack,
			 SOMAUserEthnicityLatino,
			 SOMAUserEthnicitySouthAsian,
			 SOMAUserEthnicityOriental,
			 SOMAUserEthnicityOther
		5. education:
			 SOMAUserEducationLessThanSecondary,
			 SOMAUserEducationSecondary,
			 SOMAUserEducationUniversity,
			 SOMAUserEducationAdvanced
 		6. interestedIn:
			 SOMAUserGenderInterestBoth,
			 SOMAUserGenderInterestMale,
			 SOMAUserGenderInterestFemale
 		7. maritalStatus:
			 SOMAUserMaritalStatusSingle,
			 SOMAUserMaritalStatusMarried,
			 SOMAUserMaritalStatusDivorced
 		8. country: String
 		9. countryCode: String
	   10. region: String
	   11. city: String
	   12. zip: String
 
 =====================================*/

@interface SMTTextAdViewController : UIViewController
@end

