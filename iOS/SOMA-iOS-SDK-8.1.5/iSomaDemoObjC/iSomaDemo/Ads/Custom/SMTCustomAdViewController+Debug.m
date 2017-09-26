//
//  SMTCustomAdViewController+Debug.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 27/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdViewController+Debug.h"
#import "SMTCustomAdViewController.h"
#import "SMTCustomAdPreference.h"
@import QuartzCore;

@implementation SMTCustomAdViewController (Debug)

- (void) configureDebug{
	if ([SMTCustomAdPreference sharedInstance].isLogEnabled) {
		self.lcTopDebugView.constant = 0;
	} else {
		self.lcTopDebugView.constant = -50;
	}
	
	if ([SMTCustomAdPreference sharedInstance].isDrawBorderEnabled) {
		self.bannerView.layer.borderColor = [UIColor redColor].CGColor;
		self.bannerView.layer.borderWidth = 1.0f;
	} else {
		self.bannerView.layer.borderWidth = 0.0f;
	}
		
	self.lblSettings.text = [NSString stringWithFormat:@"Type:%@, Dim:%@, width/height:%@", [SMTCustomAdPreference sharedInstance].type,[SMTCustomAdPreference sharedInstance].dimension, [SMTCustomAdPreference sharedInstance].widthHeight];
	[UIView animateWithDuration:0.3f animations:^{
		[self.view layoutIfNeeded];
	}];
	
	self.lblLog.text = @"";
}

- (void) debugLog:(NSString*) log{
	NSLog(@">>%@", log);
	self.lblLog.text = log;
}
@end
