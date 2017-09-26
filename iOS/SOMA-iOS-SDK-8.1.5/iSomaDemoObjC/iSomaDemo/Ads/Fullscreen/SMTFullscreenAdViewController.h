//
//  SMTFullscreenAdViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*====================================
 
		iSoma Text Ad Demo
 
 =====================================*/

// Step 1: Import library
#import <iSoma/iSoma.h>

@interface SMTFullscreenAdViewController : UIViewController

// Step 2: Declare a banner view property
@property(nonatomic, strong) SOMAFullScreenBanner* bannerView;
@end
