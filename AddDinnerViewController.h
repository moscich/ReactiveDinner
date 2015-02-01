//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RACCommand;
@class AddDinnerViewModel;
@class RACSignal;

@interface AddDinnerViewController : UIViewController

@property (nonatomic, strong) AddDinnerViewModel *viewModel;

@property(nonatomic, strong) RACSignal *completeSignal;
@end