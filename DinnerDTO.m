//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import <AFNetworking/AFURLRequestSerialization.h>
#import "DinnerDTO.h"


@implementation DinnerDTO {

}

- (BOOL)isEqual:(id)other {
  if (other == self)
    return YES;
  if (!other || ![[other class] isEqual:[self class]])
    return NO;

  return [self isEqualToDto:other];
}

- (BOOL)isEqualToDto:(DinnerDTO *)dto {
  if (self == dto)
    return YES;
  if (dto == nil)
    return NO;
  if (self.title != dto.title && ![self.title isEqualToString:dto.title])
    return NO;
  return YES;
}

- (NSUInteger)hash {
  return [self.title hash];
}


@end