//
//  StopWatchViewController.m
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "StopWatchViewController.h"
#import "LocationManager.h"

@interface StopWatchViewController ()

@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@property (nonatomic, assign) NSTimeInterval startTime;

@end

@implementation StopWatchViewController
BOOL running;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timeLabel.text = @"0:00.0";
    running = NO;
    
    [self.timerButton sizeToFit];
    [self.timerButton setTitle:@"Start" forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleTimer:(id)sender {
    if (!running) {
        running = YES;
        self.startTime = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [self updateTime];
    }else{
        running = NO;
        self.timeLabel.text = @"0:00.0";
        self.distanceLabel.text = @"0.0m";
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [self updateTime];
    }
}

- (void)updateTime
{
    LocationManager *locationInstance = [LocationManager sharedLocationInstance];
    
    if (!running){
        [locationInstance stopTrackingDistance];
        return;
    }
    
    //Calc time difference
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = currentTime - self.startTime;
    
    //Extract/format time
    int mins = (int) elapsed/60.0;
    elapsed -= mins * 60.0;
    int secs = (int) elapsed;
    elapsed -= secs;
    int fraction = elapsed * 10.0;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%u:%02u.%u", mins, secs, fraction];
    
    //Constantly update time after 0.1 seconds
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
    
    //Get distance
    [locationInstance startTrackingDistance];
    double distance = [locationInstance updateDistance];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2fm", distance];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
