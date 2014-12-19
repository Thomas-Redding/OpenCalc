//
//  GraphingTableController.h
//  Calculator
//
//  Created by Thomas Redding on 12/16/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "Tab.h"
#import "GraphingFunction.h"

@interface GraphingTableController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

@property NSMutableArray* list;
@property Tab *parent;

-(GraphingTableController*)init;
-(void) add;
-(void) remove: (NSTableView*) tableView;

@end
