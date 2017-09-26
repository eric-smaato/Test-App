//
//  SMTCustomAdOptionsViewController.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iSoma/iSoma.h>

#import "SMTCustomAdOptionTableManager.h"
@interface SMTCustomAdOptionsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) SMTCustomAdOptionTableManager* tableManager;
@property(nonatomic, weak) SOMAAdView* adView;
@end
