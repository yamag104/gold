//
//  LocationManager.m
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import "LocationManager.h"
#import "MathManager.h"

@interface LocationManager()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *firstLocation;
@property (strong, nonatomic) CLLocation *lastLocation;
@property (nonatomic) double distanceTravelled;

@end

@implementation LocationManager

- (id) init
{
    self = [super init];
    
    if (self != nil)
    {
        [self getLocationManager];
    }
    return self;
}


+ (instancetype)sharedLocationInstance
{
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)getLocationManager
{
    if ([CLLocationManager locationServicesEnabled])
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 50.0;
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }
    else{
        
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be showing past informations. To enable, Settings->Location->location services->on" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:@"Continue",nil];
        [servicesDisabledAlert show];
        [servicesDisabledAlert setDelegate:self];
    }
}

- (void)requestWhenInUseAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertViews = [[UIAlertView alloc] initWithTitle:title
                                                             message:message
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"Settings", nil];
        [alertViews show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            // do some error handling
        }
            break;
        default:{
            [self.locationManager startUpdatingLocation];
        }
            break;
    }
}

#pragma mark - CLLocation delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    if (self.firstLocation == nil) {
//        self.firstLocation = locations.firstObject;
//    }else{
//        self.lastLocation = locations.lastObject;
//        CLLocationDistance distance =[self.firstLocation distanceFromLocation:self.lastLocation];
//        //CLLocationDistance lastDistance = [self.lastLocation distanceFromLocation:self.lastLocation];
//        self.distanceTravelled += distance;
//        NSLog(@"DIST TRAVELLED: %f", self.distanceTravelled);
//        
//    }
//    self.lastLocation = locations.lastObject;
    
    
    CLLocation* newLocation = [locations lastObject];
    
    NSTimeInterval age = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (age > 120) return;    // ignore old (cached) updates
    
    if (newLocation.horizontalAccuracy < 0) return;   // ignore invalid udpates
    
    // EDIT: need a valid oldLocation to be able to compute distance
    if (self.lastLocation == nil || self.lastLocation.horizontalAccuracy < 0) {
        self.lastLocation = newLocation;
        return;
    }
    
    CLLocationDistance distance = [newLocation distanceFromLocation: self.lastLocation];
    
    NSLog(@"%6.6f/%6.6f to %6.6f/%6.6f for %2.0fm, accuracy +/-%2.0fm",
          self.lastLocation.coordinate.latitude,
          self.lastLocation.coordinate.longitude,
          newLocation.coordinate.latitude,
          newLocation.coordinate.longitude,
          distance,
          newLocation.horizontalAccuracy);
    
    self.distanceTravelled += distance;
    
    self.lastLocation = newLocation;    // save newLocation for next time
}


- (double)updateDistance
{
    return self.distanceTravelled;
}

- (void)startTrackingDistance
{
    [self.locationManager startUpdatingLocation];
}

- (void)stopTrackingDistance
{
    self.distanceTravelled = 0.0;
    [self.locationManager stopUpdatingLocation];
    
}

@end
