//
//  SMTVideoAdViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTVideoAdViewController.h"
#import "SMTAppSettings.h"

#import <iSoma/SOMAConstants.h>

@interface SMTVideoAdViewController ()<SOMABannerViewDelegate>
@end

@implementation SMTVideoAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	/*------------------------------------------------------------
		Step 3: Create, configure and add the banner view
	 --------------------------------------------------------------*/
	self.bannerView = [[SOMABannerView alloc] initWithDimension:kSOMAAdDimensionDefault];
	self.bannerView.adSettings.publisherId = [SMTAppSettings defaultSettings].adPublisherID;
	self.bannerView.adSettings.adspaceId = [SMTAppSettings defaultSettings].adSpaceID;
	
	self.bannerView.autoReloadEnabled = [SMTAppSettings defaultSettings].isAutoRefreshEnabled;
	if ([SMTAppSettings defaultSettings].isAutoRefreshEnabled) {
		self.bannerView.autoReloadFrequency = [SMTAppSettings defaultSettings].autoRefreshValue;
	}
	
	[self.bannerView setLocationUpdateEnabled:[SMTAppSettings defaultSettings].isGpsEnabled];
	
	[self.view addSubview:_bannerView];
	
	/*-------------------------------------------------------------
		Step 4: Set adType Video so that it will only show Text Ad
	 --------------------------------------------------------------*/
	self.bannerView.adSettings.adType = kSOMAAdTypeVideo;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	/*---------------------------------------------------------------------------
	 Step 5: Start loading the banner and also optionally enable auto reload
	 ----------------------------------------------------------------------------*/
	[self.bannerView asyncLoadNewBanner];
	
	/*-----------------------------------------------------------------------
	 Optional: Set delegate
	 ------------------------------------------------------------------------*/
	self.bannerView.delegate  = self;
	
	/*-----------------------------------------------------------------------
	 Optional: Handle Ad receive success and failure notification
	 ------------------------------------------------------------------------*/
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onAdDidReceiveSuccess:)
												 name:kSOMAAdDownloaderDidReceiveAdNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onAdDidReceiveFailure:)
												 name:kSOMAAdDownloaderDidFailNotification
											   object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	/*------------------------------------------------------------
	 Step 6: Disable auto reload before the view disappers
	 --------------------------------------------------------------*/
	[self.bannerView setAutoReloadEnabled:NO];
	
	/* clean up */
	self.bannerView.delegate = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:kSOMAAdDownloaderDidReceiveAdNotification
												  object:nil];
}

/*-----------------------------------------------------------------------
 Optional: Handle Ad receive success and failure notification
 ------------------------------------------------------------------------*/
- (void)onAdDidReceiveSuccess:(NSNotification*) notification{
	NSLog(@"Ad Received success!\n %@" ,[notification.userInfo objectForKey:kSOMAAdDownloaderUserInfoDictionaryReceivedBannerKey]);
}
- (void)onAdDidReceiveFailure:(NSNotification*) notification{
	NSLog(@"Ad Received failed!");
	[[[UIAlertView alloc] initWithTitle:@"Failed to load Ad"
								message:nil
							   delegate:nil
					  cancelButtonTitle:@"Close"
					  otherButtonTitles:nil] show];
}

#pragma mark - SOMABannerViewDelegate
- (void)landingPageWillBeDisplayed{
	NSLog(@"Landing page will be displayed");
}
- (void)landingPageHasBeenClosed{
	NSLog(@"Landing page has been closed");
}

@end
