//
//  DataSource.m
//  gold
//
//  Created by Yoko Yamaguchi on 5/1/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+ (instancetype)sharedInstance {
    static DataSource *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataSource alloc] init];
    });
    return sharedInstance;
}

@end
