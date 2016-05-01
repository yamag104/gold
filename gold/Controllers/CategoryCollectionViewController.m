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

@end

@implementation CategoryCollectionViewController

static NSString * const reuseIdentifier = @"categoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.categories count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *eventname = [self.categories objectAtIndex:indexPath.section];
    cell.imageView.image = [UIImage imageNamed:eventname];
    cell.imageView.layer.cornerRadius = 5.0;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.imageView.layer.borderWidth = 1.0;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (void)getCategories {
    NSString *path = [NSString stringWithFormat:@"%@%@", kFirebaseURL,kComponentCategories];
    Firebase *categoryRef = [[Firebase alloc] initWithUrl:path];
    self.categories = [NSMutableArray arrayWithObjects:@"Running", @"Cycling", nil];
    [[categoryRef queryOrderedByValue] observeEventType:FEventTypeChildAdded
                                              withBlock:^(FDataSnapshot *snapshot) {
                                                  NSDictionary *categ = snapshot.value;
                                                  [self.categories addObject:categ[@"title"]];
                                                  NSLog(@"%@", categ[@"title"]);
                                              }];
}

@end
