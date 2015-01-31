//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DinnerSessionManager : NSObject
@property(nonatomic, strong) AFHTTPSessionManager *manager;

- (id)initWithSessionManager:(AFHTTPSessionManager *)manager;

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


@end