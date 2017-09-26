//
//  SMTCustomAdOptionTableSectionFactory.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 22/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTCustomAdOptionConstants.h"
#import "SMTCustomAdOptionTableSection.h"


@protocol SMTCustomAdOptionTableSectionFactory <NSObject>
- (id<SMTCustomAdOptionTableSection>) createSection:(NSDictionary*) configuration;
@end
