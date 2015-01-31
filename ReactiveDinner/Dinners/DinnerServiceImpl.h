//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DinnerService.h"

@class AFHTTPSessionManager;
@class AFHTTPRequestOperation;
@class DinnerSessionManager;


@interface DinnerServiceImpl : NSObject <DinnerService>
@property(nonatomic, strong) DinnerSessionManager *sessionManager;

- (id)initWithSessionManager:(DinnerSessionManager *)manager;

@end