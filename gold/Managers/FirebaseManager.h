//
//  FirebaseManager.h
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface FirebaseManager : NSObject

@property(nonatomic, strong) Firebase *firebase;

+ (instancetype)sharedInstance;

@end
