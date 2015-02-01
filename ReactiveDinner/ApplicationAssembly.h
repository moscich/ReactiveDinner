//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Typhoon/TyphoonAssembly.h>

@class DinnerAssembly;


@interface ApplicationAssembly : TyphoonAssembly
@property(nonatomic, strong) DinnerAssembly *dinnerAssembly;
@end