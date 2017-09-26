//
//  SMTLeaderboardAdViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 11/06/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/*====================================
 
 iSoma Leaderboard Ad Demo
 
 =====================================*/

// Step 1: Import library
#import <iSoma/iSoma.h>

@interface SMTLeaderboardAdViewController : UIViewController

// Step 2: Declare a banner view property
@property  IBOutlet SOMAAdView* bannerView;
@end