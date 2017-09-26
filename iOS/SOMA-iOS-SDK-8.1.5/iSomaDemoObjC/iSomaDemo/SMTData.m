//
//  SMTDemoListDataProvider.m
//  iSomaDemo
//
//  Created by Aman Shaikh on 20/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import "SMTData.h"
#import "SMTPlistDataSource.h"

@implementation SMTData

+ (id<SMTDataSource>) defaultDataSource{
	return [SMTData plistDataSource];
}
+ (id<SMTDataSource>) plistDataSource{
	static id<SMTDataSource> _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		NSString *path = [[NSBundle mainBundle] pathForResource:@"DemoListData" ofType:@"plist"];
		NSAssert([[NSFileManager defaultManager] fileExistsAtPath:path] == YES
				 , ([NSString stringWithFormat:@"Plist file does not exist:%@", path]));
        _instance = [[SMTPlistDataSource alloc] initWithPlistFileAtPath:path];
    });
    return _instance;
    return nil;
}

@end
