//
//  UserTabBarController.m
//  gold
//
//  Created by Brian Wong on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "UserTabBarController.h"

@interface UserTabBarController ()

@property (strong, nonatomic) UIButton *raisedTabButton;

@end

@implementation UserTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.raisedTabButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.raisedTabButton.frame = CGRectMake(0, 0, 40, 40);
    self.raisedTabButton.titleLabel.font = [UIFont boldSystemFontOfSize:30.0];
    [self.raisedTabButton setTitle:@"+" forState:UIControlStateNormal];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
