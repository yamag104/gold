//
//  StopWatchViewController.m
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "Athelete.h"
#import "StopWatchViewController.h"
#import <Firebase/Firebase.h>

@interface StopWatchViewController ()

@property (weak, nonatomic) IBOutlet UIButton *timerButton;
@property (weak, nonatomic) IBOutlet UILabel *recordLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;

@property (nonatomic, assign) NSTimeInterval startTime;

@end

@implementation StopWatchViewController
BOOL running;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.timeLabel.text = @"0:00.0";
    self.recordLabel.text = @"9.34";
    self.recordLabel.layer.cornerRadius = 0.3;
    running = NO;
    if ([DataSource sharedInstance].eventName) {
        self.eventLabel.text = [DataSource sharedInstance].eventName;
    }
    
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
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)updateTime {
    if (!running) return;
    
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
}

- (void)saveRecord {
    Firebase *ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",
                      kComponentUsers, [Athelete sharedInstance].userId, kComponentRecords];
    Firebase *recordsRef = [ref childByAppendingPath:path];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary *record = @{
        kDateCreated: dateString,
        kValue: @"1:00:00"
        };
    [recordsRef setValue:record];
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
