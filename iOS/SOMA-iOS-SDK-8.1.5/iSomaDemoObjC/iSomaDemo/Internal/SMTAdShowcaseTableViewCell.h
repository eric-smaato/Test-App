//
//  SMTAdShowcaseTableViewCell.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 23/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMTAdShowcaseTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel* lblTitle;
@property(nonatomic, weak) IBOutlet UILabel* lblDetail;
@property(nonatomic, weak) IBOutlet UIImageView* image;
@property(nonatomic, weak) IBOutlet UIView* imageBackgroundView;
@end
