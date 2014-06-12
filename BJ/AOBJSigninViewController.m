//
//  AOBJSigninViewController.m
//  BJ
//
//  Created by Dili Hu on 5/28/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJSigninViewController.h"
#import "AOBJAuthManager.h"
#import "AOBJHomeViewController.h"

@interface AOBJSigninViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailString;
@property (weak, nonatomic) IBOutlet UITextField *passwordString;
@property(strong) NSDictionary *maybeInfo;
@end

@implementation AOBJSigninViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    [self.emailString becomeFirstResponder];
}

-(void) login {
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://localhost:3000/csrf.json" parameters:nil success:^(NSURLSessionDataTask *task, id csrfResponse) {
        NSLog(@"%@", [task.response.class description]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        NSLog(@"%@", httpResponse.allHeaderFields);
        
        NSDictionary *parameters = @{@"email":self.emailString.text,
                                     @"password":self.passwordString.text,
                                     @"authenticity_token" : [httpResponse.allHeaderFields objectForKey:@"X-Csrf-Token"]
                                     };
        
        [manager POST:@"http://localhost:3000/sessions.json" parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  
                  self.maybeInfo = responseObject;
                  
                  for(NSString *key in [self.maybeInfo allKeys]) {
                      NSLog(@"%@ is =%@=", key, [self.maybeInfo objectForKey:key]);
                  }
                  
                  NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                  [defaults setObject: cookiesData forKey: @"sessionCookies"];
                  [defaults synchronize];
                  
                  // NSLog([cookiesData]);
                  
                  [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
                  
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
                                                                      message:[error localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Ok"
                                                            otherButtonTitles:nil];
                  alertView.accessibilityLabel = @"connectionError";
                  [alertView show];
              }];
    } failure:nil];
    
}

- (IBAction)loginButton:(UIButton *)sender
{
    [self login];
}


- (bool) textFieldShouldReturn:(UITextField*) textField {
    if (textField == self.emailString) {
        [self.passwordString becomeFirstResponder];
    } else if (textField == self.passwordString) {
        [self.passwordString resignFirstResponder];
        [self login];
    }
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LoginSuccess"]) {
        AOBJHomeViewController *vc2 = (AOBJHomeViewController *)segue.destinationViewController;
        vc2.userInfo = [self.maybeInfo mutableCopy];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
