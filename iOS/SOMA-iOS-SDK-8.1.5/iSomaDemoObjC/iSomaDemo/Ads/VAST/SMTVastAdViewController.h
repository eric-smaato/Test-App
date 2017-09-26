//
//  SMTVastAdViewController.h
//  iSomaInternalDemo
//
//  Created by Aman Shaikh on 12/02/15.
//  Copyright (c) 2015 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iSoma/iSoma.h>

@interface SMTVastAdViewController : UIViewController
@property(nonatomic, weak) IBOutlet UIButton* loadAdButton;
@property(nonatomic, weak) IBOutlet UIButton* showFullScreenButton;
@property(nonatomic, strong) SOMAInterstitialVideoAdView* adView;
@end
