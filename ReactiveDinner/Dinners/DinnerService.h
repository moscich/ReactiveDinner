//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DinnerService <NSObject>

- (void)getDinners:(void (^)(NSArray *dinners))callback;

@end