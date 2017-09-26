//
//  SMTRewardedVideoAdViewController.m
//  iSomaDemoObjc
//
//  Created by Ankur Shivani on 02/12/2016.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import "SMTRewardedVideoAdViewController.h"
#import <iSoma/iSoma.h>

@interface SMTRewardedVideoAdViewController () <SOMAAdViewDelegate>
@property(nonatomic, weak) IBOutlet UIButton* loadAdButton;
@property(nonatomic, weak) IBOutlet UIButton* showFullScreenButton;
@property(nonatomic, strong) SOMARewardedVideo* adView;
@end

@implementation SMTRewardedVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SOMARewardedVideo* adview = [[SOMARewardedVideo alloc] init];
    self.adView = adview;
    self.adView.delegate = self;
    
    self.adView.adSettings.autoReloadEnabled = NO;
    self.showFullScreenButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)onLoadAd:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showFullScreenButton.hidden = YES;
        self.loadAdButton.enabled = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.adView load];
        });
    });
    
}

- (IBAction)onShowAd:(id)sender{
    if (self.adView.isLoaded) {
        [self.adView show];
    }
}

#pragma mark -
#pragma mark - SOMAAdViewDelegate
#pragma mark -

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaAdViewWillLoadAd:(SOMAAdView*)adview{
    NSLog(@"Ad View Will Load");
}

- (void)somaAdViewDidLoadAd:(SOMAAdView*)adview{
    NSLog(@"Ad View Loaded");
    
    [self.loadAdButton setTitle:@"Ad loaded!" forState:UIControlStateDisabled];
    self.showFullScreenButton.hidden = NO;
}

- (void)somaAdView:(SOMAAdView*)adview didFailToReceiveAdWithError:(NSError *)error{
    BOOL reloadEnabled = adview.adSettings.isAutoReloadEnabled;
    int reloadInterval = adview.adSettings.autoReloadInterval;
    NSString* reloadTimeMessage = @"";
    if (reloadEnabled) {
        reloadTimeMessage = [NSString stringWithFormat:@", in %d Seconds", reloadInterval];
    }
	NSLog(@"AdView failed to load: %@", [error localizedDescription]);
    
    self.loadAdButton.enabled = YES;
    [self.loadAdButton setTitle:@"Failed to load, retry" forState:UIControlStateNormal];
    self.showFullScreenButton.hidden = YES;
}

- (BOOL)somaAdViewShouldEnterFullscreen:(SOMAAdView*)adview{
    NSLog(@"Ad Clicked, will go fullscreen");
    return YES;
}

- (void)somaAdViewDidExitFullscreen:(SOMAAdView*)adview{
    NSLog(@"Exited full screen");
}
- (void)somaAdViewWillHide:(SOMAAdView*)adview{
    NSLog(@"Ad view will hide");
    self.loadAdButton.enabled = YES;
    self.showFullScreenButton.hidden = YES;
    [self.loadAdButton setTitle:@"Reload Ad" forState:UIControlStateNormal];
}

- (void)somaAdView:(SOMAAdView *)adview didReceiveVideoAdEvent:(SOMAVideoAdTrackingEvent)event {
    if (event == SOMAVideoAdTrackingEventStart) {
        NSLog(@"Rewarded Video Started");
    } else if (event == SOMAVideoAdTrackingEventFirstQuartile) {
        NSLog(@"Rewarded video reached first quartile");
    } else if (event == SOMAVideoAdTrackingEventMidpoint) {
        NSLog(@"Rewarded video reached mid point");
    } else if (event == SOMAVideoAdTrackingEventThirdQuartile) {
        NSLog(@"Rewarded video reached third quartile");
    } else if (event == SOMAVideoAdTrackingEventComplete) {
        NSLog(@"Rewarded video Completed");
    }
}

@end
