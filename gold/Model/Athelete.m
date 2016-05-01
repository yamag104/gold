//
//  Athelete.m
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "Athelete.h"

@implementation Athelete

+ (instancetype)sharedInstance {
    static Athelete *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Athelete alloc] init];
    });
    return sharedInstance;
}

@end
