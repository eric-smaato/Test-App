//
//  SMTFullscreenAdViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTFullscreenAdViewController.h"
#import "SMTAppSettings.h"

@implementation SMTFullscreenAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	/*------------------------------------------------------------
		Step 3: Create, configure and add the banner view
	 --------------------------------------------------------------*/
	self.bannerView = [[SOMAFullScreenBanner alloc] init];
	self.bannerView.adSettings.publisherId = [SMTAppSettings defaultSettings].adPublisherID;
	self.bannerView.adSettings.adspaceId = [SMTAppSettings defaultSettings].adSpaceID;
			
	[self.view addSubview:_bannerView];
	
	/*-------------------------------------------------------------
		Step 4: Set adType Text so that it will only show Text Ad
	 --------------------------------------------------------------*/
	self.bannerView.adSettings.adType = kSOMAAdTypeAll;
}

@end
