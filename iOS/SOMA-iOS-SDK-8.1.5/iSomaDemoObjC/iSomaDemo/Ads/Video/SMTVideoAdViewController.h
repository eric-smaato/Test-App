//
//  SMTVideoAdViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*====================================
 
		iSoma Video Ad Demo
 
 =====================================*/

// Step 1: Import library
#import <iSoma/SOMABannerView.h>

@interface SMTVideoAdViewController : UIViewController

// Step 2: Declare a banner view property
@property(nonatomic, strong) SOMABannerView* bannerView;
@end
