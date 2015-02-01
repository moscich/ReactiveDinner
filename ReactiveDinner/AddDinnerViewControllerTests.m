//
//  AddDinnerViewControllerTests.m
//  ReactiveDinner
//
//  Created by Marek Moscichowski on 01.02.15.
//  Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ReactiveCocoa/RACSignal.h>
#import "AddDinnerViewController.h"
#import "DinnerDTO.h"
#import "UIView+UnitTests.h"
#import "UIButton+UnitTests.h"

@interface AddDinnerViewControllerTests : XCTestCase

@end

@implementation AddDinnerViewControllerTests

- (void)test_completeSignal_whenUserEnterInfo_returnsProvidedInfo{
    AddDinnerViewController *dinnerViewController = [AddDinnerViewController new];
    XCTestExpectation *expectation = [self expectationWithDescription:@"signal"];
    [dinnerViewController.completeSignal subscribeNext:^(DinnerDTO *dinner) {
      [expectation fulfill];
      XCTAssertEqualObjects(dinner.title, @"Test title");
      XCTAssertEqualObjects(dinner.additionalInfo, @"Test info");
    }];

    [dinnerViewController.view textFieldWithAccessibilityLabel:@"Title"].text = @"Test title";
    [dinnerViewController.view textFieldWithAccessibilityLabel:@"Additional Info"].text = @"Test info";
    [[dinnerViewController.view buttonWithLabelText:@"Send"] simulateTap];

    [self waitForExpectationsWithTimeout:0 handler:nil];
}

@end
