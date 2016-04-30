//
//  LocationManager.h
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

//Make location public

+ (instancetype)sharedInstance;

-(void)updateCurrentLocation;

@property (nonatomic, strong)NSString *currentCity;
@property (nonatomic, strong)NSString *currentState;


@end
