//
//  DataSource.h
//  gold
//
//  Created by Yoko Yamaguchi on 5/1/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

@property(nonatomic, strong) NSMutableDictionary *categories;
@property(nonatomic, strong) NSString *currentEvent;

+ (instancetype)sharedInstance;

@end
