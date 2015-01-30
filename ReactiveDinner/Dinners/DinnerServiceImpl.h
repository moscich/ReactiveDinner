//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DinnerService.h"

@class AFHTTPSessionManager;
@class AFHTTPRequestOperation;


@interface DinnerServiceImpl : NSObject <DinnerService>
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;

- (id)initWithSessionManager:(AFHTTPSessionManager *)manager;

@end