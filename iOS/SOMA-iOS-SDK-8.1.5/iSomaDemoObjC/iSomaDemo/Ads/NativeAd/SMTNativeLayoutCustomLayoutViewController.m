//
//  SMTNativeLayoutCustomLayoutViewController.m
//  iSomaDemoObjc
//
//  Created by Aman Shaikh on 04.02.16.
//  Copyright © 2016 Smaato Inc. All rights reserved.
//

#import "SMTNativeLayoutCustomLayoutViewController.h"
#import "SMTNativeLayoutCell.h"
#import <iSoma/iSoma.h>

@interface SMTNativeLayoutCustomLayoutViewController ()<UITableViewDataSource, UITableViewDelegate, SOMANativeAdDelegate>
@property int nativeAdRow;
@property SOMANativeAd* nativeAd;
@property IBOutlet UITableView* tableView;
@property BOOL isAdAvailable;
@property int totalNumberOfRows;

@property NSDictionary* layoutTitleToEnum;
@property NSDictionary* layoutTitleToPreferredHeight;
@end

@implementation SMTNativeLayoutCustomLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = self.layoutTitle;
	
	self.layoutTitleToEnum = @{
							   @"App Wall"			: [NSNumber numberWithInteger:SOMANativeAdLayoutAppWall]
							  , @"Content Wall"		: [NSNumber numberWithInteger:SOMANativeAdLayoutContentWall]
							  , @"News Feed"		: [NSNumber numberWithInteger:SOMANativeAdLayoutNewsFeed]
							  , @"Content Stream"	: [NSNumber numberWithInteger:SOMANativeAdLayoutContentStream]
							  , @"Chat List"		: [NSNumber numberWithInteger:SOMANativeAdLayoutChatList]
							  , @"Carousel"			: [NSNumber numberWithInteger:SOMANativeAdLayoutCarousel]
							  };
	
	
	self.layoutTitleToPreferredHeight = @{
							   @"App Wall"			: @50.0
							   , @"Content Wall"	: @300.0
							   , @"News Feed"		: @50.0
							   , @"Content Stream"	: @250.0
							   , @"Chat List"		: @50.0
							   , @"Carousel"		: @280.0
							   };
	
	self.totalNumberOfRows = 100;
	SOMANativeAd* nativeAd = [[SOMANativeAd alloc] initWithPublisherId:@"0" adSpaceId:@"3075"];
	nativeAd.delegate = self;
	nativeAd.layout = (SOMANativeAdLayout)[self.layoutTitleToEnum[self.layoutTitle] integerValue];
	[nativeAd load];
	self.nativeAd = nativeAd;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (self.isAdAvailable) {
		return self.totalNumberOfRows + 1;
	}
	return self.totalNumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell* cell;
	if (self.isAdAvailable && indexPath.row == self.nativeAdRow) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"nativead"];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.nativeAd registerViewForUserInteraction:cell.contentView];
		});
	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
		cell.textLabel.text = [NSString stringWithFormat:@"I am row %ld", indexPath.row - (self.isAdAvailable && (indexPath.row > self.nativeAdRow ) ? 1 : 0)];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"Cell clicked!");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (self.isAdAvailable && indexPath.row == self.nativeAdRow) {
		return [self.layoutTitleToPreferredHeight[self.layoutTitle] doubleValue];
	}
	return 50;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	[self updateAdPosition];
}

- (void)updateAdPosition{
	if (self.isAdAvailable) {
		NSIndexPath* currentPath =  [NSIndexPath indexPathForRow:self.nativeAdRow inSection:0];
		if ([self isRowVisible:currentPath]) {
			return;
		}
		
		self.nativeAdRow = (int)[self.tableView indexPathsForVisibleRows][0].row;
		NSIndexPath* newPath = [NSIndexPath indexPathForRow:self.nativeAdRow inSection:0];
		[self.tableView moveRowAtIndexPath:currentPath toIndexPath:newPath];
		[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		[self.tableView scrollToRowAtIndexPath:newPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
		
//		dispatch_async(dispatch_get_main_queue(), ^{
//			[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
//		});
	}
}


-(BOOL)isRowVisible:(NSIndexPath*)path {
	NSArray *indexes = [self.tableView indexPathsForVisibleRows];
	for (NSIndexPath *index in indexes) {
		if (index.row == path.row) {
			return YES;
		}
	}
	
	return NO;
}

#pragma mark -
#pragma mark - SOMANativeAdDelegate
#pragma mark -

-(UIViewController *)somaRootViewController {
    return self;
}

- (void)somaNativeAdDidLoad:(SOMANativeAd*)nativeAd{
	self.isAdAvailable = YES;
	self.nativeAdRow = 0;
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	[tempArray addObject:[NSIndexPath indexPathForRow:self.totalNumberOfRows inSection:0]];
	
	[[self tableView] beginUpdates];
	[[self tableView] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationFade];
	[[self tableView] endUpdates];

	
	[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
	
	[self updateAdPosition];
	
//	dispatch_async(dispatch_get_main_queue(), ^{
//		[self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationAutomatic];
//	});
}

- (void)somaNativeAdDidFailed:(SOMANativeAd*)nativeAd withError:(NSError*)error{
	self.isAdAvailable = NO;
}

- (BOOL)somaNativeAdShouldEnterFullScreen:(SOMANativeAd *)nativeAd {
	
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
