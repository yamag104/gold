//
//  FirebaseManager.m
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "FirebaseManager.h"

@implementation FirebaseManager

+ (instancetype)sharedInstance {
    static FirebaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FirebaseManager alloc] init];
        [self initialize];
    });
    return sharedInstance;
}

- (void)initialize {
    self.firebase = [[Firebase alloc] initWithUrl:kFirebaseURL];
}


@end
