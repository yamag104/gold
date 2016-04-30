//
//  LoginViewController.m
//  gold
//
//  Created by Yoko Yamaguchi on 4/30/16.
//  Copyright © 2016 lahacks2016. All rights reserved.
//

#import "Athelete.h"
#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Firebase/Firebase.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernamedField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonClicked:(id)sender {
    [self loginWithFirebase];
    
}
- (IBAction)signupButtonClicked:(id)sender {
    [self signupWithFirebase];
}

- (void)layoutViews {
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (void)signupWithFirebase {
    Firebase *ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    NSString *username = self.usernamedField.text;
    NSString *password = self.passwordField.text;
    [ref createUser:username password:password
withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            [self showErrorAlertWithTitle:@"Signup failed"];
        } else {
            NSString *uid = [result objectForKey:@"uid"];
            NSLog(@"[LoginViewController.m] Successfully created user account with uid: %@", uid);
            [Athelete sharedInstance].userId = uid;
        }
    }];
}

- (void)loginWithFirebase {
    Firebase *ref = [[Firebase alloc] initWithUrl:kFirebaseURL];
    NSString *username = self.usernamedField.text;
    NSString *password = self.passwordField.text;
    [ref authUser:username password:password
withCompletionBlock:^(NSError *error, FAuthData *authData) {
    if (error) {
        [self showErrorAlertWithTitle:@"Login failed"];
    } else {
        // We are now logged in
        NSLog(@"[LoginViewController.m] Successfully logged in");
    }
}];
}

- (void)showErrorAlertWithTitle:(NSString *)title {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title
                                                    message:@"There was an error. Please try again later."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
