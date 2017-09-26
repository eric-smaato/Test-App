//
//  SOMAIADInterstitialViewController.m
//  SomaClientSideMediation
//
//  Created by Aman Shaikh on 13.10.15.
//  Copyright © 2015 Smaato Inc. All rights reserved.
//

#import "SOMAIADInterstitialViewController.h"
#import "SOMAIAdMediationPlugin.h"
#import <iSoma/iSoma.h>

@interface SOMAIADInterstitialViewController ()
@property BOOL isPresented;
@property SOMACloseButton* closeButton;
@end

@implementation SOMAIADInterstitialViewController

- (void)loadView{
	UIView* view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (self.closeButton == nil) {
		self.closeButton = [[SOMACloseButton alloc] initWithFrame:CGRectMake(10, 20, 32, 32)];
		[self.view addSubview:self.closeButton];
		[self.closeButton addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
	}
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.view bringSubviewToFront:self.closeButton];
}

- (void)onClose:(id)sender{
	[self dismissViewControllerAnimated:YES completion:^{
		[self.plugin adDidDismissFullscreen];
	}];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ADBannerViewDelegate
#pragma mark -
- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd{
	self.isPresented = NO;
	[self.plugin adLoadedWithView:nil];
}

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error{
	self.isPresented = NO;
	[self.plugin adLoadFailedWithError:error];
}

- (BOOL)interstitialAdActionShouldBegin:(ADInterstitialAd *)interstitialAd willLeaveApplication:(BOOL)willLeave{
	[self.plugin adWillPresentFullscreen];
	self.isPresented = YES;
	if (willLeave) {
		[self.plugin adWillLeaveApplication];
	}
	return YES;
}

- (void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd{
	if (interstitialAd.isLoaded && self.isPresented == YES) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self dismissViewControllerAnimated:YES
									 completion:^{
										 [self.plugin adDidDismissFullscreen];
									 }];
		});
	}
}

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd{
//	interstitialAd = nil;
}

@end
