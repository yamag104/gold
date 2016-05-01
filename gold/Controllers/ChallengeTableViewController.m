//
//  ChallengeTableViewController.m
//  gold
//
//  Created by Yoko Yamaguchi on 5/1/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "ChallengeTableViewController.h"
#import "StopWatchViewController.h"

@interface ChallengeTableViewController ()

@end

@implementation ChallengeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.challenges = [[NSMutableArray alloc] init];
    self.categories = [DataSource sharedInstance].categories;
    self.event = [DataSource sharedInstance].currentEvent;
    [self getChallenges];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.challenges count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"challengeCell" forIndexPath:indexPath];
    NSArray *curItem = self.challenges[indexPath.item];
    cell.textLabel.text = curItem[0];
    cell.detailTextLabel.text = curItem[1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StopWatchViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"stopwatchVC"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    NSArray *curItem = self.challenges[indexPath.item];
    [DataSource sharedInstance].eventName = curItem[0];
    [self presentViewController:vc animated:YES completion:NULL];
}

- (void)getChallenges {
    if (self.categories && self.event) {
        self.eventId = self.categories[self.event];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@%@", kFirebaseURL,kComponentChallenges];
    Firebase *categoryRef = [[Firebase alloc] initWithUrl:path];
    [[categoryRef queryOrderedByValue] observeEventType:FEventTypeChildAdded
                                              withBlock:^(FDataSnapshot *snapshot) {
                                                  NSDictionary *categ = snapshot.value;
                                                  NSDictionary *categD = categ[@"categories"];
                                                  NSString *eId = [[categD allKeys] firstObject];
                                                  if ([self.eventId isEqualToString:eId]) {
                                                      NSString *description = categ[@"description"];
                                                      NSString *title = categ[@"title"];
//                                                      __weak __typeof__(self) weakSelf = self;
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          NSArray *arr = [[NSArray alloc]initWithObjects:title,description, nil];
                                                          [self.challenges addObject:arr];
                                                          [self.tableView reloadData];
                                                      });
                                                  }
                                              }];
}

@end
