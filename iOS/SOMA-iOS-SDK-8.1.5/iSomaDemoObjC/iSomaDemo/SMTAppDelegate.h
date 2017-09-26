//
// SMTAppDelegate.h
//  iSomaDemo
//
//  Created by Shaikh Aman on 13/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void) showMenu;
- (void) hideMenu;
-(void) pushViewControllerInCenterView:(UIViewController*)vc;

- (void) showWelcomeMessage;
- (void) dontShowWelcomeMessageAgain;
- (void) hideLeftEdge;
- (void) showLeftEdge;

@end
