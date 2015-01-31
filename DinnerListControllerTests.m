//
//  DinnerListControllerTests.m
//  ReactiveDinner
//
//  Created by Marek Moscichowski on 30.01.15.
//  Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Typhoon/Typhoon.h>
#import <AFNetworking/AFNetworking.h>
#import "DinnerListController.h"
#import "DinnerDTO.h"
#import "DinnerAssembly.h"
#import "TyphoonPatcher.h"
#import "UIButton+UnitTests.h"
#import "AddDinnerViewController.h"

@interface DinnerListControllerTests : XCTestCase

@property(nonatomic, strong) DinnerListController *dinnerListController;
@property(nonatomic, strong) TyphoonBlockComponentFactory *factory;
@end

@implementation DinnerListControllerTests

- (void)setUp {
  self.factory = [TyphoonBlockComponentFactory factoryWithAssembly:[DinnerAssembly assembly]];
}

- (void)test_viewDidLoad_whenSucceed_showReceivedDinnersInTableView {
  [self patchNetworkCallsWithObject:[self stubTestDinnersSessionMenager]];

  self.dinnerListController = [self.factory componentForType:[DinnerListController class]];

  UIView *view = [self.dinnerListController view];

  UITableView *tableView = (UITableView *) [self subViewOfClass:[UITableView class] inView:view];
  int numberOfCells = [tableView.dataSource tableView:tableView numberOfRowsInSection:0];
  UITableViewCell *tableViewCell1 = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
  UITableViewCell *tableViewCell2 = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];

  XCTAssertEqual(numberOfCells, 2);
  XCTAssertEqualObjects(tableViewCell1.textLabel.text, @"Test dinner 1");
  XCTAssertEqualObjects(tableViewCell2.textLabel.text, @"Test dinner 2");
}

- (void)test_whenAddDinnerButtonTapped_always_showAddDinnerViewController{
  self.dinnerListController = [self.factory componentForType:[DinnerListController class]];
  [self.dinnerListController view];
  id partialMock = [OCMockObject partialMockForObject:self.dinnerListController];
  [[partialMock expect] presentViewController:[OCMArg checkWithBlock:^BOOL(id obj) {
    return [obj isKindOfClass:[AddDinnerViewController class]];
  }] animated:YES completion:nil];

  [self.dinnerListController.navigationItem.rightBarButtonItem simulateTap];

  [partialMock verify];
}

- (void)patchNetworkCallsWithObject:(id)object {
  TyphoonPatcher *patcher = [TyphoonPatcher new];
  [patcher patchDefinitionWithKey:@"AFHttpSessionManager" withObject:^id {
    return object;
  }];
  [self.factory attachPostProcessor:patcher];
}

- (id)stubTestDinnersSessionMenager {
  id stubSessionManager = [OCMockObject mockForClass:[AFHTTPSessionManager class]];
  [((AFHTTPSessionManager *) [[stubSessionManager stub] andDo:^(NSInvocation *invocation) {
    void (^passedBlock)(NSURLSessionDataTask *task, NSString *);
    [invocation getArgument:&passedBlock atIndex:4];
    passedBlock(nil, [self stubDinners]);
  }]) GET:@"/dinners" parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
  return stubSessionManager;
}

- (UIView *)subViewOfClass:(Class)subviewClass inView:(UIView *)view {
  for (UIView *subview in view.subviews) {
    if ([subview isKindOfClass:subviewClass])
      return subview;
  }
  return nil;
}

- (NSString *)stubDinners {
  return @"{  "
          "   \"dinners\":[  "
          "      {  "
          "         \"title\":\"Test dinner 1\""
          "      },"
          "      {  "
          "         \"title\":\"Test dinner 2\""
          "      }"
          "   ]"
          "}";
}

@end