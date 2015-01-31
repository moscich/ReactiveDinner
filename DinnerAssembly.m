//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "DinnerAssembly.h"
#import "DinnerListController.h"
#import "DinnerManager.h"
#import "DinnerServiceImpl.h"
#import "DinnerSessionManager.h"


@implementation DinnerAssembly {

}

- (id)dinnerListViewController {
  return [TyphoonDefinition withClass:[DinnerListController class] configuration:^(TyphoonDefinition *definition) {
    [definition useInitializer:@selector(initWithDinnerManager:) parameters:^(TyphoonMethod *initializer) {
      [initializer injectParameterWith:[self dinnerManager]];
    }];
  }];
}

- (id)dinnerManager {
  return [TyphoonDefinition withClass:[DinnerManager class] configuration:^(TyphoonDefinition *definition) {
    [definition useInitializer:@selector(initWithService:) parameters:^(TyphoonMethod *initializer) {
      [initializer injectParameterWith:[self dinnerService]];
    }];
  }];
}

- (id)dinnerService {
  return [TyphoonDefinition withClass:[DinnerServiceImpl class] configuration:^(TyphoonDefinition *definition) {
    [definition useInitializer:@selector(initWithSessionManager:) parameters:^(TyphoonMethod *initializer) {
      [initializer injectParameterWith:[self dinnerSessionManager]];
    }];
  }];
}

- (id)dinnerSessionManager {
  return [TyphoonDefinition withClass:[DinnerSessionManager class] configuration:^(TyphoonDefinition *definition) {
    [definition useInitializer:@selector(initWithSessionManager:) parameters:^(TyphoonMethod *initializer) {
      [initializer injectParameterWith:[self sessionManager]];
    }];
  }];
}

- (id)sessionManager {
  return [TyphoonDefinition withClass:[AFHTTPSessionManager class] key:@"AFHttpSessionManager"];
}

@end