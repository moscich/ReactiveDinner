//
// Created by Marek Moscichowski on 01.02.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "UIButton+UnitTests.h"


@implementation UIButton (UnitTests)

- (void)simulateTap {
  [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end