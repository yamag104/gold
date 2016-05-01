//
//  UserTabBarController.m
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "UserTabBarController.h"
#import "StopWatchViewController.h"

@interface UserTabBarController ()

@property (strong, nonatomic) UIButton *raisedTabButton;

@end

@implementation UserTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    self.raisedTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.raisedTabButton.frame = CGRectMake(0, 0, 50, 50);
    self.raisedTabButton.titleLabel.font = [UIFont boldSystemFontOfSize:50.0];
    [self.raisedTabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.raisedTabButton setTitle:@"+" forState:UIControlStateNormal];
    [self.raisedTabButton addTarget:self action:@selector(startEventFlow:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat heightDifference = self.raisedTabButton.frame.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        self.raisedTabButton.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        self.raisedTabButton.center = center;
    }
    
    [self.view addSubview:self.raisedTabButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startEventFlow:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StopWatchViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"stopwatchVC"];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:NULL];
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
