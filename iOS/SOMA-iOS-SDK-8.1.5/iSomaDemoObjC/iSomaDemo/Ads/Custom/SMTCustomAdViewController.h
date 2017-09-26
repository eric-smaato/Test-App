//
//  SMTCustomAdViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iSoma/SOMAAdSettings.h>

/*====================================
 
		iSoma Custom Ad Demo
 
 =====================================*/

// Step 1: Import library
#import <iSoma/iSoma.h>

@interface SMTCustomAdViewController : UIViewController<SOMAAdViewDelegate>

// Step 2: Declare a banner view property
@property(nonatomic, weak) IBOutlet SOMAAdView* bannerView;


// Debug view
@property (weak, nonatomic) IBOutlet UIView* debugView;
@property (weak, nonatomic) IBOutlet UILabel* lblSettings;
@property (weak, nonatomic) IBOutlet UILabel* lblLog;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* lcTopDebugView;
@end
