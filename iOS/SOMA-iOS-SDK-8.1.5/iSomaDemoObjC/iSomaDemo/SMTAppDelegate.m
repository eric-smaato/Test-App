//
// SMTAppDelegate.m
//  iSomaDemo
//
//  Created by Shaikh Aman on 13/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTAppDelegate.h"
#import "SMTAppSettings.h"
#import <iSoma/iSoma.h>

#import "IIViewDeckController.h"

@implementation SOMAAdView(workaround)
- (BOOL) isCovered{
	return false;
}
@end

@interface SMTAppDelegate()
@property (nonatomic, strong) IIViewDeckController* viewDeckController;
@end

@implementation SMTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    [[SMTAppSettings defaultSettings] load];
	[self showDemoList];
		
    return YES;
}

- (void) showWelcomeMessage{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"dontShowWelcomeView"] == NO) {
		UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
		UIViewController* welcomeViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"welcomeViewController"];
		welcomeViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		
		self.viewDeckController.centerController.view.hidden = YES;
		[self.viewDeckController presentViewController:welcomeViewController animated:YES completion:^{
				self.viewDeckController.centerController.view.hidden = NO;
		}];
	}
}

- (void) dontShowWelcomeMessageAgain{
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"dontShowWelcomeView"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) showDemoList{
	UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	UIViewController* menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"leftMenuController"];
	
	UINavigationController* navigationController = (UINavigationController *) self.window.rootViewController;
	self.viewDeckController =  [[IIViewDeckController alloc] initWithCenterViewController:navigationController leftViewController:menuController rightViewController:nil];
	self.viewDeckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
	[self.viewDeckController setLeftSize:60.0f];
	
	self.window.rootViewController = self.viewDeckController;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)applicationWillResignActive:(UIApplication *)application{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[SMTAppSettings defaultSettings] save];
}

- (void) hideLeftEdge{
	[self.viewDeckController setLeftSize:0.0f];
}
- (void) showLeftEdge{
	[self.viewDeckController setLeftSize:60.0f];
}

- (void) showMenu{
	[self.viewDeckController openLeftViewAnimated:YES];
}
- (void) hideMenu{
	[self.viewDeckController closeLeftViewAnimated:YES];
}

-(void) pushViewControllerInCenterView:(UIViewController*)vc{
	[(UINavigationController*)self.viewDeckController.centerController pushViewController:vc animated:YES ];
}

@end
