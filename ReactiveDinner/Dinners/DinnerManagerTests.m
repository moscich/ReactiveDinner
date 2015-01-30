//
//  DinnerManagerTests.m
//  ReactiveDinner
//
//  Created by Marek Moscichowski on 30.01.15.
//  Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "DinnerManager.h"
#import "DinnerService.h"
#import "DinnerServiceImpl.h"
#import "AFHTTPSessionManager.h"

@interface DinnerManagerTests : XCTestCase

@end

@implementation DinnerManagerTests

- (void)test_getDinners_whenSuccess_saveDinnersToArray {
    DinnerManager *dinnerManager = [DinnerManager new];
    DinnerServiceImpl *dinnerService = [DinnerServiceImpl new];
    id mockedManager = [OCMockObject mockForClass:[AFHTTPSessionManager class]];
    dinnerService.sessionManager = mockedManager;
    dinnerManager.service = dinnerService;
}

@end
