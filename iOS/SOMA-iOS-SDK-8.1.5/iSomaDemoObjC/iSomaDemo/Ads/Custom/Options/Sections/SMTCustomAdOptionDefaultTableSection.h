//
//  SMTCustomAdOptionDefaultTableSection.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTCustomAdOptionTableSection.h"

@interface SMTCustomAdOptionDefaultTableSection : NSObject<SMTCustomAdOptionTableSection>

@property(nonatomic, strong, getter = titleForSection) NSString* title;

@property(nonatomic, strong) NSArray* values;

@end
