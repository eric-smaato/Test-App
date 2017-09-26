//
//  SMTDemoListDataProvider.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTDataSource.h"

@interface SMTData : NSObject

+ (id<SMTDataSource>) plistDataSource;
+ (id<SMTDataSource>) defaultDataSource;
@end
