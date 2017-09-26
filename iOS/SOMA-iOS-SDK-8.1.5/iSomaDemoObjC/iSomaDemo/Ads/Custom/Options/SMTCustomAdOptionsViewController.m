//
//  SMTCustomAdOptionsViewController.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTCustomAdOptionsViewController.h"
#import "SMTCustomAdOptionExpandableTableCell.h"
#import "SMTCustomAdOPtionTableManager.h"
#import "SMTCustomAdPreference.h"

@interface SMTCustomAdOptionsViewController()
@property (nonatomic, weak) IBOutlet UIToolbar* toolbar;
@end
@implementation SMTCustomAdOptionsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

-(IBAction)onCancel:(id)sender{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)onSave:(id)sender{
	[[SMTCustomAdPreference sharedInstance] update:[SMTCustomAdPreference currentPreference]];
	SMTCustomAdPreference* pref = [SMTCustomAdPreference sharedInstance];
	self.adView.adSettings.dimension = pref.dimensionValue;
	self.adView.adSettings.type = pref.typeValue;
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [[self.tableManager sectionAtIndex:section] numberOfRows];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [self.tableManager numberSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	return [[self.tableManager sectionAtIndex:indexPath.section] cellForIndexPath:indexPath forTableView:tableView];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[[self.tableManager sectionAtIndex:indexPath.section] cellTouchedAtIndexPath:indexPath onTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.text = [tableViewHeaderFooterView.textLabel.text capitalizedString];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [[self.tableManager sectionAtIndex:section] titleForSection];
}

@end
