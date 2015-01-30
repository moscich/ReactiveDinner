//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DinnerManager;


@interface DinnerListController : UIViewController
@property(nonatomic, strong) DinnerManager *dinnerManager;

- (id)initWithDinnerManager:(DinnerManager *)manager;

@end