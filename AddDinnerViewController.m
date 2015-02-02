//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AddDinnerViewController.h"
#import "DinnerDTO.h"

@interface AddDinnerViewController ()
@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UITextField *textField2;
@property (nonatomic, strong) RACSubject *subject;
@end

@implementation AddDinnerViewController {

}

- (RACSignal *)completeSignal {
  self.subject = [RACSubject subject];
  return self.subject;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    DinnerDTO *dinnerDTO = [DinnerDTO new];
    dinnerDTO.title = self.textField.text;
    dinnerDTO.additionalInfo = self.textField2.text;
    [self.subject sendNext:dinnerDTO];
    [self.subject sendCompleted];
  }];
  [[self.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    [self.subject sendError:nil];
  }];
}

@end