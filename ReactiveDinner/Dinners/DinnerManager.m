//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DinnerManager.h"
#import "DinnerService.h"


@implementation DinnerManager {

}
- (id)initWithService:(id <DinnerService>)service {
  self = [super init];
  if(self){
    self.service = service;

  }
  return self;
}

- (void)askForDinners {
  @weakify(self)
  RAC(self, dinners) = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    @strongify(self)
    [self.service getDinners:^(NSArray *dinners) {
      [subscriber sendNext:dinners];
      [subscriber sendCompleted];
    }];
    return nil;
  }];
}

@end