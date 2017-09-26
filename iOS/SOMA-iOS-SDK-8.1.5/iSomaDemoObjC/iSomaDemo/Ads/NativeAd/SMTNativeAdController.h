//
//  SMTNativeAdController.h
//  iSomaInternalDemo
//
//  Created by Aman Shaikh on 17/12/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTNativeAdController : UIViewController

@property IBOutlet UILabel* nativeAdCallToAction;
@property IBOutlet UILabel* status;
@property IBOutlet UIView* nativeAdView;
@property IBOutlet UILabel* nativeAdTitle;
@property IBOutlet UILabel* nativeAdDescription;
@property IBOutlet UIImageView* nativeAdIcon;
@property IBOutlet UIImageView* nativeAdImage;

@property IBOutletCollection(UIImageView) NSArray* nativeAdRatingImages;

@end
