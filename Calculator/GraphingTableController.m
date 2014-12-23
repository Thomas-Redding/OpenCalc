//
//  GraphingTableController.m
//  Calculator
//
//  Created by Thomas Redding on 12/16/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "GraphingTableController.h"

@implementation GraphingTableController

-(GraphingTableController*)init {
    return self;
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.list.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if([[tableColumn identifier] isEqual: @"isVisible"]) {
        return [NSNumber numberWithBool:[[self.list objectAtIndex:row] isVisible]];
    }
    else {
        return [[self.list objectAtIndex:row] string];
    }
}

-(IBAction)checkBoxState:(id)sender {
    //
}

-(void) add {
    GraphingFunction* newFunc = [[GraphingFunction alloc] initWithBrain:self.parent.brain];
    newFunc.string = @"";
    newFunc.index = self.list.count;
    [self.list addObject:newFunc];
}

-(void) remove: (NSTableView*) tableView {
    NSMutableArray *toRemove = [[NSMutableArray alloc] init];
    for(int i=0; i<[tableView numberOfRows]; i++) {
        if ([tableView isRowSelected: i])
            [toRemove addObject:[NSNumber numberWithInt:i]];
    }
    
    unsigned long j;
    unsigned long k;
    for(unsigned long i=0; i<toRemove.count; i++) {
        j = toRemove.count-i-1;
        k = [[toRemove objectAtIndex:j] intValue];
        
        [self.list removeObjectAtIndex:k];
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification {
    [self.parent childToParentMessage:@"cell selected"];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)value forTableColumn:(NSTableColumn *)column row:(NSInteger)row {
    if([value boolValue]) {
        [[self.list objectAtIndex:row] setIsVisible: true];
    }
    else {
        [[self.list objectAtIndex:row] setIsVisible: false];
    }
    [tableView reloadData];
    [self.parent childToParentMessage:@"checkbox selected"];
}

@end
