//
//  RankSystemManager.h
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Athelete.h"

const NSString *kEventRunning;

@interface RankSystemManager : NSObject

@property (nonatomic, strong) NSDictionary *runningData;
@property (nonatomic, strong) NSDictionary *swimmingData;

-(void)getCurrentGoldMetalist:(NSString *)forEvent;
-(void)getCurrentSilverMetalist:(NSString *)forEvent;

@end
