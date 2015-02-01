#import "AddDinnerViewModel.h"//
// Created by Marek Moscichowski on 30.01.15.
// Copyright (c) 2015 Marek Mościchowski. All rights reserved.
//

#import "DinnerListController.h"
#import "DinnerManager.h"
#import "DinnerDTO.h"
#import "AddDinnerViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

@interface DinnerListController () <UITableViewDataSource>
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation DinnerListController {

}

- (id)initWithDinnerManager:(DinnerManager *)manager {
  self = [super init];
  if (self) {
    self.dinnerManager = manager;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  @weakify(self)
  [[RACObserve(self, dinnerManager.dinners) ignore:nil] subscribeNext:^(id x) {
    @strongify(self)
    [self.tableView reloadData];
  }];

  [self.dinnerManager askForDinners];

  AddDinnerViewController *addDinnerViewController = [AddDinnerViewController new];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
  RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self)
    [self presentViewController:addDinnerViewController animated:YES completion:nil];

    [RACObserve(addDinnerViewController, viewModel) subscribeNext:^(id x) {
      NSLog(@"x = %@", x);
    }];

    return [RACSignal empty];
  }];
//
//  [[RACSignal
//          combineLatest:@[[RACObserve(addDinnerViewController.viewModel, title) ignore:nil], [RACObserve(addDinnerViewController.viewModel, additionalInfo) ignore:nil]]
//                 reduce:(id (^)()) ^(NSString *title, NSString *additionalInfo) {
//                   @strongify(self)
//                   DinnerDTO *dinner = [DinnerDTO new];
//                   dinner.title = title;
//                   dinner.additionalInfo = additionalInfo;
//                   return dinner;
//                 }] subscribeNext:^(DinnerDTO *dinner) {
//
//  }];

  self.navigationItem.rightBarButtonItem.rac_command = command;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dinnerManager.dinners.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [UITableViewCell new];
  cell.textLabel.text = ((DinnerDTO *) self.dinnerManager.dinners[(NSUInteger) indexPath.row]).title;
  return cell;
}


@end