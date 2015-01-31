//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <objc/message.h>
#import "UIButton+UnitTests.h"


@implementation UIBarButtonItem (UnitTests)

- (void)simulateTap {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
  [self.target performSelector:self.action];
}

@end