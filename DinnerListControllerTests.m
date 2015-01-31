//
//  DinnerListControllerTests.m
//  ReactiveDinner
//
//  Created by Marek Moscichowski on 30.01.15.
//  Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMockObject.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <OCMock/OCMStubRecorder.h>
#import <Typhoon/TyphoonBlockComponentFactory.h>
#import "DinnerListController.h"
#import "OCMArg.h"
#import "DinnerDTO.h"
#import "DinnerAssembly.h"
#import "TyphoonPatcher.h"

@interface DinnerListControllerTests : XCTestCase

@property(nonatomic, strong) DinnerListController *dinnerListController;
@property(nonatomic, strong) TyphoonBlockComponentFactory *factory;
@end

@implementation DinnerListControllerTests

- (void)setUp {
  self.factory = [TyphoonBlockComponentFactory factoryWithAssembly:[DinnerAssembly assembly]];
}

- (void)test_viewDidLoad_whenSucceed_showReceivedDinnersInTableView {
  [self patchAFnetworkingWithStub];

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

- (void)patchAFnetworkingWithStub {
  TyphoonPatcher *patcher = [TyphoonPatcher new];
  [patcher patchDefinitionWithKey:@"AFHttpSessionManager" withObject:^id {
    return [self stubTestDinnersSessionMenager];
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