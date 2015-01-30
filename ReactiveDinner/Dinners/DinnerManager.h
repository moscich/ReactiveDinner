//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DinnerService;


@interface DinnerManager : NSObject
@property(nonatomic, strong) id <DinnerService> service;
@property(nonatomic, strong) NSArray *dinners;

- (id)initWithService:(id <DinnerService>)service;

- (void)askForDinners;
@end