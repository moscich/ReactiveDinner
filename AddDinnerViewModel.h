//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddDinnerViewModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *additionalInfo;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToModel:(AddDinnerViewModel *)model;

- (NSUInteger)hash;
@end