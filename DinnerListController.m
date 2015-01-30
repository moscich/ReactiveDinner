//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "DinnerListController.h"
#import "DinnerManager.h"
#import "DinnerDTO.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

@interface DinnerListController () <UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation DinnerListController {

}

- (id)initWithDinnerManager:(DinnerManager *)manager {
  self = [super init];
  if(self){
    self.dinnerManager = manager;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  @weakify(self)
  [[RACObserve(self, dinnerManager.dinners) ignore:nil] subscribeNext : ^(id x) {
    @strongify(self)
    [self.tableView reloadData];
  }];

  [self.dinnerManager askForDinners];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dinnerManager.dinners.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [UITableViewCell new];
  cell.textLabel.text = ((DinnerDTO *)self.dinnerManager.dinners[(NSUInteger) indexPath.row]).title;
  return cell;
}


@end