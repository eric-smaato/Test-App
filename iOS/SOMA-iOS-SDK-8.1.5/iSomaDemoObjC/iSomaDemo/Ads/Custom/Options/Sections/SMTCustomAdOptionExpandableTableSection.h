//
//  SMTCustomAdOptionTableSection.h
//  iSomaDemo
//
//  Created by Aman Shaikh on 21/05/14.
//  Copyright (c) 2014 Smaato Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMTCustomAdOptionTableSection.h"

@interface SMTCustomAdOptionExpandableTableSection : NSObject<SMTCustomAdOptionTableSection>

@property(nonatomic, assign, getter = isExpanded) BOOL expanded;
@property(nonatomic, strong, getter = titleForSection) NSString* title;
@property(nonatomic, strong) NSString* expandableCellId;
@property(nonatomic, strong) NSString* expandableCellTitle;
@property(nonatomic, strong) NSString* settingsKey;
@property(nonatomic, strong) NSString* defaultCellId;
@property(nonatomic, assign) BOOL valueTypeIsSize;
@property(nonatomic, strong) NSArray* values;

@end
