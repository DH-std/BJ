//
//  AOBJHomeViewController.m
//  BJ
//
//  Created by Dili Hu on 5/27/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJHomeViewController.h"
#import "UIImageView+KHGravatar.h"
#import "AOBJGameViewController.h"

#import "NSString+MD5.h"   

@interface AOBJHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *userChips;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIButton *beginnerButton;
@property (weak, nonatomic) IBOutlet UIButton *intermediateButton;
@property (weak, nonatomic) IBOutlet UIButton *highRollButton;
@end

@implementation AOBJHomeViewController
- (IBAction)logoutButtonTapped:(UIButton *)sender {
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
//    NSDictionary *parameters = @{@"id":[@"/d" self.userInfo.id],
//                                 @"remember_token":};

    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager DELETE:@"http://localhost:3000/signout" parameters:nil
          success:^(NSURLSessionDataTask *task, id responseObject) {
              for(NSString *key in [responseObject allKeys]) {
                  NSLog(@"%@ is %@", key, [responseObject objectForKey:key]);
              }
              
              [self performSegueWithIdentifier:@"logoutSuccess" sender:self];
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
                                                                  message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
              alertView.accessibilityLabel = @"connectionError";
              [alertView show];
          }];    

    
//    NSString *string = @"http://localhost:3000/users/1.json";
//    NSURL *url = [NSURL URLWithString:string];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        self.userInfo = (NSDictionary *)responseObject;
////        NSLog(@"JSON Retrieved");
////        
////        for(NSString *key in [self.userInfo allKeys]) {
////            NSLog(@"%@ is %@", key, [self.userInfo objectForKey:key]);
////        }
//        
//        self.testLabel.text = [self.userInfo objectForKey:@"name"];
//        
//        // [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving User Information"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    
//    [operation start];
}


- (IBAction)beginnerButtonTapped:(UIButton *)sender {
  //  [self.userInfo ];
  
//  @{@"email":self.emailString.text,
//      @"password":self.passwordString.text,
//      @"authenticity_token" : [httpResponse.allHeaderFields objectForKey:@"X-Csrf-Token"]
//      };
}


- (IBAction)intermediateButtonTapped:(UIButton *)sender {
    
}


- (IBAction)highRollButtonTapped:(UIButton *)sender {
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toGameSegue"]) {
        AOBJGameViewController *vc2 = (AOBJGameViewController *)segue.destinationViewController;
//        NSMutableDictionary *newDict = 
//        
//        vc2.gameInfo = self.maybeInfo;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // User info.
    self.userName.text = [self.userInfo objectForKey:@"name"];
    NSRange div100 = NSMakeRange(0, self.userChips.text.length);
    self.userLevel.text = [NSString stringWithFormat:@"Level: %d",
                           [[self.userChips.text substringWithRange:div100] intValue] + 1];
    self.userChips.text = [NSString stringWithFormat:@"Chips: %@",
                           [self.userInfo objectForKey:@"chips"]];
    
    // User gravatar.
    NSString *userEmail = [self.userInfo objectForKey:@"email"];
    [self.userImage setImageWithGravatarEmailAddress:userEmail
                                    placeholderImage:nil
                                    defaultImageType:KHGravatarDefaultImageIdenticon
                                        forceDefault:YES
                                              rating:KHGravatarRatingG];
}

@end

