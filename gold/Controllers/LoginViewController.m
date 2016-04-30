//
//  LoginViewController.m
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Firebase/Firebase.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    [self signupWithFirebase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutViews {
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (void)signupWithFirebase {
    Firebase *ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    [ref createUser:@"bobtony@example.com" password:@"correcthorsebatterystaple"
withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            // There was an error creating the account
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"Successfully created user account with uid: %@", uid);
        }
    }];
}

- (void)loginWithFirebase {
    
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
