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
#import "FirebaseManager.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernamedField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) NSString *username;
@property (weak, nonatomic) NSString *password;
@property (weak, nonatomic) NSString *email;

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
    if ([self hasValidParams]) {
        [self loginWithFirebase];
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    } else {
        [self showErrorAlertWithTitle:@"Please enter your username & password"];
    }
}

- (IBAction)signupButtonClicked:(id)sender {
    if ([self hasValidParams]) {
        [self signupWithFirebase];
    } else {
        [self showErrorAlertWithTitle:@"Please enter your username & password"];
    }
}

- (void)layoutViews {
    self.passwordField.secureTextEntry = YES;
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
}

- (void)signupWithFirebase {
    [[FirebaseManager sharedInstance].firebase createUser:self.email password:self.password
                                 withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
        if (error) {
            [self showErrorAlertWithTitle:@"Signup failed"];
        } else {
            NSString *uid = [result objectForKey:kUserId];
            NSLog(@"[LoginViewController.m] Successfully created user account with uid: %@", uid);
            [Athelete sharedInstance].userId = uid;
            NSString *path = [NSString stringWithFormat:@"%@/%@", kComponentUsers, uid];
            Firebase *usersRef = [[FirebaseManager sharedInstance].firebase childByAppendingPath:path];
            NSDictionary *userParams = @{
                                         kName : _username,
                                         kEmail : _email
                                         };
            [usersRef setValue:userParams];
            
        }
    }];
}

- (void)loginWithFirebase {
    [[FirebaseManager sharedInstance].firebase
     authUser:self.email
     password:self.password
     withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            [self showErrorAlertWithTitle:@"Login failed"];
        } else {
            NSLog(@"[LoginViewController.m] Successfully logged in");
        }
}];
}

- (BOOL)hasValidParams {
    self.username = self.usernamedField.text;
    self.password = self.passwordField.text;
    self.email = @"test@gmail.com";
    if (self.username && self.password && self.email) {
        return YES;
    }
    return NO;
}

- (void)showErrorAlertWithTitle:(NSString *)title {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                                           message:@"There was an error. Please try again later."
                                                    preferredStyle:UIAlertControllerStyleAlert              ];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:nil];
    
    [alertController addAction: ok];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.usernamedField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
