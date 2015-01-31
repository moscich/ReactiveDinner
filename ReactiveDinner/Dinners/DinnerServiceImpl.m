//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "DinnerServiceImpl.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperation.h"
#import "DinnerSessionManager.h"
#import "DinnerArrayDTO.h"


@implementation DinnerServiceImpl {

}
- (id)initWithSessionManager:(DinnerSessionManager *)manager {
  self = [super init];
  if(self){
    self.sessionManager = manager;
  }
  return self;
}

- (void)getDinners:(void (^)(NSArray *dinners))callback {
  [self.sessionManager GET:@"/dinners" parameters:nil success:^(id responseObject) {
    NSString *responseString = responseObject;
    DinnerArrayDTO *dinnerArrayDTO = [[DinnerArrayDTO alloc] initWithString:responseString error:nil];
    callback(dinnerArrayDTO.dinners);
  } failure:^(NSError *error) {

  }];
}


//- (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
//  [self.sessionManager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//    success(responseObject);
//  } failure:^(NSURLSessionDataTask *task, NSError *error) {
//    if(failure)
//      failure(error);
//  }];
//}


@end