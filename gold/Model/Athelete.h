//
//  Athelete.h
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Athelete : NSObject

@property(strong, nonatomic) NSString *userId;
@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) NSInteger age;
@property(strong, nonatomic) NSMutableArray *record;

+ (instancetype)sharedInstance;

@end
