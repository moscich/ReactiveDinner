//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "DinnerSessionManager.h"

@implementation DinnerSessionManager {

}
- (id)initWithSessionManager:(AFHTTPSessionManager *)manager {
  self = [super init];
  if(self){
    self.manager = manager;
  }
  return self;
}

- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
  [self.manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
    success(responseObject);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    failure(error);
  }];
}

@end