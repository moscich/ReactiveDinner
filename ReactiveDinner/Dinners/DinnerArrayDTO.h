//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

#import "DinnerDTO.h"

@protocol DinnerDTO
@end

@interface DinnerArrayDTO : JSONModel
@property(nonatomic, strong) NSArray <DinnerDTO> *dinners;
@end