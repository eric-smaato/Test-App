//
//  SMTCustomAdOptionTableSectionManager.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTCustomAdOptionTableSection.h"

@interface SMTCustomAdOptionTableManager : NSObject

- (NSInteger) numberSections;
- (id<SMTCustomAdOptionTableSection>) sectionAtIndex:(NSInteger)index;
+ (instancetype) createManager;
@end
