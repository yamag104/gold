//
//  LocationManager.h
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+ (instancetype)sharedLocationInstance;

- (double)updateDistance;
- (void)stopTrackingDistance;
- (void)startTrackingDistance;

@end
