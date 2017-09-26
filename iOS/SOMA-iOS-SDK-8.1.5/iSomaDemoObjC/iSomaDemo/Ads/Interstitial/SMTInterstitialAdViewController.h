//
//  SMTInterstitialAdViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iSoma/iSoma.h>

/*====================================
 
 iSoma Interstitial Ad Demo
 
 Interstitial ad means showing ad as native content or showing fullscreen
 once ready.
 
 Fullscreen Interstitial Ad:
 ------- ------- ------- -------
 Often shown after the user completes some actions e.g. completing one round in a
 game. The Ad is downloaded silently and shown naturally.
 
 Sometimes, its a good strategy to ask user voluntarily see an Ad to get some point rewards. e.g. The popular 'Clumsy Ninja' game, a gamer can earn money/gold by watching a Video Ad.
 
 
 Native Content
 -----
 How Facebook shows Ad as a wall post! Say, your app shows a list of images.
 Once the add is ready, you can insert the Ad in the image list.
 
 
 =====================================*/

@interface SMTInterstitialAdViewController : UIViewController
@property(nonatomic, weak) IBOutlet UIButton* loadAdButton;
@property(nonatomic, weak) IBOutlet UIButton* showFullScreenButton;
@property(nonatomic, strong) SOMAInterstitialAdView* adView;
@end
