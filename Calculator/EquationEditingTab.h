//
//  EquationEditingTab.h
//  Calculator
//
//  Created by Thomas Redding on 2/20/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import "Tab.h"
#import "EquationField.h"
#import "FontManager.h"

@interface EquationEditingTab : Tab

@property EquationField *eqField;
@property FontManager *fontManager;
@property NSWindow *window;

@end
