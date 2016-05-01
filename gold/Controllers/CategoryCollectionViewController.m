//
//  CategoryCollectionViewController.m
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "CategoryCollectionViewController.h"
#import "CategoryCollectionViewCell.h"
#import "ChallengeTableViewController.h"

@interface CategoryCollectionViewController ()

@property(nonatomic) BOOL ETCisDisplayed;

@end

@implementation CategoryCollectionViewController

static NSString * const reuseIdentifier = @"categoryCell";
static NSString * const kETC = @"ETC";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCategories];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.categories count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *eventname = [self.categories objectAtIndex:indexPath.item];
    if (![UIImage imageNamed:eventname]) {
        if (!self.ETCisDisplayed) {
            self.ETCisDisplayed = YES;
            cell.imageView.image = [UIImage imageNamed:kETC];
        }
        else {
            return cell;
        }
    } else {
        cell.imageView.image = [UIImage imageNamed:eventname];
    }
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChallengeTableViewController *challengeVC = [sb instantiateViewControllerWithIdentifier:@"challengeVC"];
    NSString *eventname = [self.categories objectAtIndex:indexPath.item];
//    challengeVC.event = eventname;
//    challengeVC.categories = self.dictCategories;
    [DataSource sharedInstance].currentEvent = eventname;
    [DataSource sharedInstance].categories = self.dictCategories;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:challengeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)getCategories {
    NSString *path = [NSString stringWithFormat:@"%@%@", kFirebaseURL,kComponentCategories];
    Firebase *categoryRef = [[Firebase alloc] initWithUrl:path];
    self.categories = [[NSMutableArray alloc] init];
    [self.categories setValue:@"Test" forKey:@"Test"];
    self.dictCategories = [[NSMutableDictionary alloc] init];
    [[categoryRef queryOrderedByValue] observeEventType:FEventTypeChildAdded
                                              withBlock:^(FDataSnapshot *snapshot) {
                                                  NSString *uniqueid = snapshot.ref.key;
                                                  NSDictionary *categ = snapshot.value;
                                                  NSString *event = categ[@"title"];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.categories addObject:event];
                                                    [self.dictCategories setObject:uniqueid
                                                                            forKey:event];
                                                    [self.collectionView reloadData];
                                                });
                                              }];
}

@end
