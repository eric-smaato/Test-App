//
//  SOMAIADInterstitialViewController.h
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 13.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
@class SOMAIAdMediationPlugin;
@interface SOMAIADInterstitialViewController : UIViewController<ADInterstitialAdDelegate>
@property(nonatomic, weak) SOMAIAdMediationPlugin* plugin;
@end
