//
//  CategoryCollectionViewController.m
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "CategoryCollectionViewController.h"
#import "CategoryCollectionViewCell.h"

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
    cell.imageView.layer.cornerRadius = 5.0;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

- (void)getCategories {
    NSString *path = [NSString stringWithFormat:@"%@%@", kFirebaseURL,kComponentCategories];
    Firebase *categoryRef = [[Firebase alloc] initWithUrl:path];
    self.categories = [[NSMutableArray alloc] initWithCapacity:4];
    [[categoryRef queryOrderedByValue] observeEventType:FEventTypeChildAdded
                                              withBlock:^(FDataSnapshot *snapshot) {
                                                  NSDictionary *categ = snapshot.value;
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [self.categories addObject:categ[@"title"]];
                                                    NSLog(@"%@", categ[@"title"]);
                                                    [self.collectionView reloadData];
                                                });
                                              }];
}

@end
