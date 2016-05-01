//
//  ChallengeTableViewController.h
//  gold
//
//  Created by Yoko Yamaguchi on 5/1/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeTableViewController : UITableViewController

@property(nonatomic, strong) NSMutableArray *challenges;
@property(nonatomic, strong) NSMutableDictionary *categories;
@property(nonatomic, strong) NSString *event;
@property(nonatomic, strong) NSString *eventId;

@end
