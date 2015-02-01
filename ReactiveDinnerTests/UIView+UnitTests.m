//
// Created by Marek Moscichowski on 01.02.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "UIView+UnitTests.h"


@implementation UIView (UnitTests)
- (UIButton *)buttonWithLabelText:(NSString *)text {
  for(UIView *subview in self.subviews){
    if([subview isKindOfClass:[UIButton class]]){
      UIButton *button = (UIButton *) subview;
      if([button.titleLabel.text isEqualToString:text])
        return button;
    }
  }
  return nil;
}

- (UITextField *)textFieldWithAccessibilityLabel:(NSString *)text {
  for (UIView *subview in self.subviews) {
    if([subview.accessibilityLabel isEqualToString:text])
      return (UITextField *) subview;
  }
  return nil;
}
@end