//
//  AlgebraTab.h
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "Tab.h"
#import "CurrentAlgebraTextField.h"

@interface AlgebraTab : Tab

@property NSScrollView *algeabraHistoryScrollView;
@property NSTextView *algebraHistory;
@property CurrentAlgebraTextField *algebraCurrent;
@property unsigned long currentHistoryLine;

@end
