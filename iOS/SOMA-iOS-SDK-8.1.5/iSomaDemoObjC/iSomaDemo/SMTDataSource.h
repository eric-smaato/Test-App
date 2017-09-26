//
//  SMTDataSource.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMTDataSource <NSObject>
-(NSUInteger) numberOfDemoAds;
-(UIViewController*) viewControllerForIndexPath:(NSIndexPath*) path;
-(NSString*) titleForIndexPath:(NSIndexPath*) path;
-(NSString*) descriptionForIndexPath:(NSIndexPath*) path;
-(UIImage*) iconForIndexPath:(NSIndexPath*) path;
@end
