//
//  SMTNativeAdListViewController.m
//  iSomaDemoObjc
//
//  Created by Aman Shaikh on 04.02.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import "SMTNativeAdListViewController.h"
#import "SMTNativeLayoutCustomLayoutViewController.h"
#import "SMTNativeAdController.h"

@interface SMTNativeAdListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSArray* cellValues;
@end

@implementation SMTNativeAdListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.cellValues = @[@"Custom"
						, @"App Wall"
						, @"Content Wall"
						, @"News Feed"
						, @"Content Stream"
						, @"Chat List"
						, @"Carousel"
						];
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.cellValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	cell.textLabel.text = self.cellValues[indexPath.row];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row > 0) {
		[self performSegueWithIdentifier:@"layout" sender:self.cellValues[indexPath.row]];
	} else {
		[self performSegueWithIdentifier:@"custom" sender:@"Custom"];
	}
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"layout"]) {
		SMTNativeLayoutCustomLayoutViewController* dest = (SMTNativeLayoutCustomLayoutViewController*)segue.destinationViewController;
		dest.layoutTitle = (NSString*)sender;
	}
}

@end
