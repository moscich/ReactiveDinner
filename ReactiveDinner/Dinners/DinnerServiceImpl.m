//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "DinnerServiceImpl.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"


@implementation DinnerServiceImpl {

}
- (id)initWithSessionManager:(AFHTTPSessionManager *)manager {
  self = [super init];
  if(self){
    self.sessionManager = manager;
  }
  return self;
}

- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
  [self.sessionManager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
    success(responseObject);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    if(failure)
      failure(error);
  }];
}


@end