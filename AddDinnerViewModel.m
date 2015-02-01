//
// Created by Marek Moscichowski on 31.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "AddDinnerViewModel.h"


@implementation AddDinnerViewModel {

}

- (BOOL)isEqual:(id)other {
  if (other == self)
    return YES;
  if (!other || ![[other class] isEqual:[self class]])
    return NO;

  return [self isEqualToModel:other];
}

- (BOOL)isEqualToModel:(AddDinnerViewModel *)model {
  if (self == model)
    return YES;
  if (model == nil)
    return NO;
  if (self.title != model.title && ![self.title isEqualToString:model.title])
    return NO;
  return !(self.additionalInfo != model.additionalInfo && ![self.additionalInfo isEqualToString:model.additionalInfo]);
}

- (NSUInteger)hash {
  NSUInteger hash = [self.title hash];
  hash = hash * 31u + [self.additionalInfo hash];
  return hash;
}

- (id)valueForKey:(NSString *)key {
  if([key isEqualToString:@"title"])
    return self.title;
  if([key isEqualToString:@"additionalInfo"])
    return self.additionalInfo;
  return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key {
  if([key isEqualToString:@"title"])
    self.title = value;
  if([key isEqualToString:@"additionalInfo"])
    self.additionalInfo = value;
}

- (NSArray *)allKeys {
  return @[@"title",@"additionalInfo"];
}

- (NSArray *)allValues {
  return @[self.title, self.additionalInfo];
}

@end