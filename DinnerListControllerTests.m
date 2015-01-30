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
#import "DinnerListController.h"
#import "DinnerManager.h"
#import "DinnerServiceImpl.h"
#import "OCMArg.h"
#import "DinnerDTO.h"

@interface DinnerListControllerTests : XCTestCase

@end

@implementation DinnerListControllerTests

- (void)test_viewDidLoad_whenSucceed_showReceivedDinnersInTableView{
  id stubSessionManager = [self stubTestDinnersSessionMenager];

  id <DinnerService> dinnerService = [[DinnerServiceImpl alloc] initWithSessionManager:stubSessionManager];
    DinnerManager *dinnerManager = [[DinnerManager alloc] initWithService:dinnerService];
    DinnerListController *dinnerListController = [[DinnerListController alloc] initWithDinnerManager:dinnerManager];

    UIView *view = [dinnerListController view];

    UITableView *tableView =  (UITableView *)[self subViewOfClass:[UITableView class] inView:view];
    int numberOfCells = [tableView.dataSource tableView:tableView numberOfRowsInSection:0];
    UITableViewCell *tableViewCell1 = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UITableViewCell *tableViewCell2 = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];

    XCTAssertEqual(numberOfCells, 2);
    XCTAssertEqualObjects(tableViewCell1.textLabel.text, @"Test dinner 1");
    XCTAssertEqualObjects(tableViewCell2.textLabel.text, @"Test dinner 2");
}

- (id)stubTestDinnersSessionMenager {
  id stubSessionManager = [OCMockObject mockForClass:[AFHTTPSessionManager class]];
  [((AFHTTPSessionManager *)[[stubSessionManager stub] andDo:^(NSInvocation *invocation) {
      void (^passedBlock)(NSURLSessionDataTask *task, NSArray *);
      [invocation getArgument: &passedBlock atIndex: 4];
      passedBlock(nil, [self stubDinners]);
    }]) GET:@"/dinners" parameters:OCMOCK_ANY success:OCMOCK_ANY failure:OCMOCK_ANY];
  return stubSessionManager;
}

- (UIView *)subViewOfClass:(Class)subviewClass inView:(UIView *)view{
    for(UIView *subview in view.subviews){
        if([subview isKindOfClass:subviewClass])
            return subview;
    }
    return nil;
}

- (NSArray *)stubDinners {
  DinnerDTO *dinner1 = [DinnerDTO new];
  DinnerDTO *dinner2 = [DinnerDTO new];
  dinner1.title = @"Test dinner 1";
  dinner2.title = @"Test dinner 2";
  return @[dinner1, dinner2];
}

@end