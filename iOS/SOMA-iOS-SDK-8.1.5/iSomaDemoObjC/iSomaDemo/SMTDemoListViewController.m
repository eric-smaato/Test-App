//
//  SMTDemoListViewController.m
//  iSomaDemo
//
//  Created by Shaikh Aman on 16/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTDemoListViewController.h"
#import "SMTData.h"
#import "SMTAppDelegate.h"
#import "SMTAdShowcaseTableViewCell.h"

@interface SMTDemoListViewController ()
@property(nonatomic, strong) id<SMTDataSource> dataSource;
@property(nonatomic, weak) IBOutlet UITableView* tableView;
@end

@implementation SMTDemoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	
	self.dataSource = [SMTData plistDataSource];
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//	[self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
//	self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1];
	
	static BOOL isFirstAppearedAfterAppRan = YES;
	if (isFirstAppearedAfterAppRan) {
		isFirstAppearedAfterAppRan = NO;
		[(SMTAppDelegate*)[UIApplication sharedApplication].delegate showWelcomeMessage];
	}
}
- (void)viewDidAppear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[super viewDidAppear:animated];
	[self.tableView flashScrollIndicators];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowMenu:(id)sender{
	[(SMTAppDelegate*)[UIApplication sharedApplication].delegate showMenu];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource numberOfDemoAds];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *simpleTableIdentifier = @"demoListCellIdentifier";
	
    SMTAdShowcaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
	   
	
    cell.lblTitle.text = [self.dataSource titleForIndexPath:indexPath];
	cell.lblDetail.text = [self.dataSource descriptionForIndexPath:indexPath];
	cell.image.image = [self.dataSource iconForIndexPath:indexPath];
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	UIViewController* vc = [self.dataSource viewControllerForIndexPath:indexPath];
	vc.title = [self.dataSource titleForIndexPath:indexPath];
		
	[self.navigationController pushViewController:vc animated:YES];
}


@end
