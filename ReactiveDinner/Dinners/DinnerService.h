//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DinnerService <NSObject>

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end