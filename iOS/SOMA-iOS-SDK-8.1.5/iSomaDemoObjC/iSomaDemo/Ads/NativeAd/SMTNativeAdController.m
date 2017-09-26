//
//  SMTNativeAdController.m
//  iSomaInternalDemo
//
//  Created by Aman Shaikh on 17/12/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTNativeAdController.h"
#import <iSoma/iSoma.h>

@interface SMTNativeAdController ()<SOMANativeAdDelegate>
@property SOMANativeAd* nativeAd;
@end

@implementation SMTNativeAdController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.nativeAdView.hidden = YES;
	
	SOMANativeAd* nativeAd = [[SOMANativeAd alloc] initWithPublisherId:@"0" adSpaceId:@"3075"];
	nativeAd.delegate = self;
	nativeAd.labelForTitle = self.nativeAdTitle;
	nativeAd.labelForDescription = self.nativeAdDescription;
	nativeAd.imageViewForIcon = self.nativeAdIcon;
	nativeAd.viewForMainImage = self.nativeAdImage;
	[nativeAd load];
	self.nativeAd = nativeAd;
	
	UIBarButtonItem* reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(onReload:)];
	self.navigationItem.rightBarButtonItem = reload;
}

- (void)onReload:(id)sender{
	self.status.text = @"Loading native ad...";
	[self.nativeAd load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateRating:(float)rating{
	int fullRating = (int)rating;
	for (UIImageView* star in self.nativeAdRatingImages) {
		if (star.tag < fullRating) {
			star.image = [UIImage imageNamed:@"star-full"];
		} else if(star.tag > fullRating){
			star.image = [UIImage imageNamed:@"star-empty"];
		} else if(fullRating*1.0 < rating ){
			star.image = [UIImage imageNamed:@"star-half"];
		}
	}
}

#pragma mark -
#pragma mark - SOMANativeAdDelegate
#pragma mark -

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaNativeAdDidLoad:(SOMANativeAd*)nativeAd{
	self.status.text = @"Native ad loaded!";
	self.nativeAdCallToAction.text = nativeAd.callToAction;
	[self updateRating:nativeAd.rating];
	self.nativeAdView.alpha = 0;
	self.nativeAdView.hidden = NO;
	[UIView animateWithDuration:0.3 animations:^{
		self.nativeAdView.alpha = 1;
	} completion:^(BOOL finished) {
		[nativeAd registerViewForUserInteraction:self.nativeAdView];
	}];
}

- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error{
	self.status.text = @"No ad available";
}

- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd {
	self.status.text = @"Native ad clicked";
	[UIView animateWithDuration:0.3 animations:^{
		self.nativeAdView.alpha = 0;
	} completion:^(BOOL finished) {
	}];
	
	return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
