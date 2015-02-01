//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AddDinnerViewController.h"
#import "DinnerDTO.h"

@interface AddDinnerViewController ()
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UITextField *textField2;
@property (nonatomic, strong) RACCommand *command;
@end

@implementation AddDinnerViewController {

}

- (RACSignal *)completeSignal {
  self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    return [self combined];
  }];
  return [self.command.executionSignals flattenMap:^RACStream *(id value) {
    return value;
  }];
}

- (RACSignal *)combined {
  return [[RACSignal combineLatest:@[[self.textField rac_textSignal], [self.textField2 rac_textSignal]]
                     reduce:^id(NSString *title, NSString *info) {
                       return [self getSignal:title info:info];
                     }] flattenMap:^RACStream *(id value) {
    return value;
  }];
}

- (RACSignal *)getSignal:(NSString *)title info:(NSString *)info {
  return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    DinnerDTO *dinnerDTO = [DinnerDTO new];
    dinnerDTO.title = title;
    dinnerDTO.additionalInfo = info;
    [subscriber sendNext:dinnerDTO];
    [subscriber sendCompleted];
    return nil;
  }];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    [self.command execute:x];
  }];
}

@end