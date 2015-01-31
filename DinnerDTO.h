//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface DinnerDTO : JSONModel
@property(nonatomic, copy) NSString *title;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToDto:(DinnerDTO *)dto;

- (NSUInteger)hash;
@end