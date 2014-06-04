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
#import "AOBJHelper.h"

#import "NSString+MD5.h"   

@interface AOBJHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *userChips;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) NSArray *gamedDictionaries;
@end

@implementation AOBJHomeViewController
- (IBAction)logoutButtonTapped:(UIButton *)sender {
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.gamedDictionaries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TCtmp"];
    cell.textLabel.text = [self.gamedDictionaries[indexPath.row] objectForKey:@"game_type"];
    cell.detailTextLabel.text = @"";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toGameSegue" sender:self.gamedDictionaries[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toGameSegue"]) {
        AOBJGameViewController *vc2 = (AOBJGameViewController *)segue.destinationViewController;
        NSLog(@"%@", sender);
        vc2.gameInfo = sender;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // User info.
    self.userName.text = [self.userInfo objectForKey:@"name"];
    self.userLevel.text = [AOBJHelper levelByChips:[self.userInfo objectForKey:@"chips"]];
    self.userChips.text = [NSString stringWithFormat:@"Chips: %@",
                           [self.userInfo objectForKey:@"chips"]];
    
    // User gravatar.
    NSString *userEmail = [self.userInfo objectForKey:@"email"];
    [self.userImage setImageWithGravatarEmailAddress:userEmail
                                    placeholderImage:nil
                                    defaultImageType:KHGravatarDefaultImageIdenticon
                                        forceDefault:YES
                                              rating:KHGravatarRatingG];
    
    // Game tables.
    self.gamedDictionaries = [self.userInfo objectForKey:@"games"];
}

@end

