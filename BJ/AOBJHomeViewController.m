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
#import "AOBJGameCellView.h"

#import "NSString+MD5.h"   

@interface AOBJHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *userChips;
@property (weak, nonatomic) IBOutlet UITableView *gameTableView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) NSDictionary *gameDictionaries;
@property (strong, nonatomic) NSArray *gameTypes;
@end

@implementation AOBJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // User info.
    self.userName.text = [self.userInfo objectForKey:@"name"];
    self.userLevel.text = [NSString stringWithFormat:@"Level: %@",
                           [AOBJHelper levelByChips:[self.userInfo objectForKey:@"chips"]]];
    self.userChips.text = [NSString stringWithFormat:@"Chips: %@",
                           [self.userInfo objectForKey:@"chips"]];
    
    // User gravatar.
    [AOBJHelper setImageFor:self.userImage useEmail:[self.userInfo objectForKey:@"email"]];

    // Game tables.
    self.gameDictionaries = [self.userInfo objectForKey:@"games"];
    
    self.gameTypes = @[@"Beginner",@"Intermediate",@"High Roller"];
    
    [self.gameTableView registerNib:[UINib nibWithNibName:@"GameCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GameCellView"];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toGameSegue"]) {
        AOBJGameViewController *vc2 = (AOBJGameViewController *)segue.destinationViewController;
        NSLog(@"sender is %@", sender);
        vc2.gameInfo = sender;
        }
}


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
    return self.gameDictionaries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AOBJGameCellView *cell = [tableView dequeueReusableCellWithIdentifier:@"GameCellView"];
    NSDictionary *game = [self gameForCellAtIndexPath:indexPath];
    cell.gameTitle.text = [game objectForKey:@"game_type"];
    cell.gameBetAmounts.text = [game objectForKey:@"bet"];
    cell.buttonLabel.text = [game valueForKey:@"button"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *game = [self gameForCellAtIndexPath:indexPath];
    
    NSNumber *chips = [self.userInfo objectForKey:@"chips"];
    NSNumber *min = [game objectForKey:@"min_bet"];
    
    NSLog(@"game dictionary%@", game);
    NSLog(@"chips %@, needs %@", chips, min);
    
    if ( [chips compare:min] == -1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Enough Chips"
            message:@"The chips you currenly own is not enough to join this game table. Please choose a different table to join."
            delegate:nil
            cancelButtonTitle:@"Ok"
            otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    AOBJHTTPClient *client = [AOBJHTTPClient sharedAOBJHTTPClient];
    [client updateGame:[game valueForKey:@"id"]
             forPlayer:[game valueForKey:@"user_id"]
            withAction:[game valueForKey:@"button"]
     thenDo:^(NSURLSessionDataTask *task, id responseObject) {
         [self performSegueWithIdentifier:@"toGameSegue" sender:responseObject];
     }];
}


- (NSDictionary *)gameForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSString *gameType = self.gameTypes[indexPath.row];
    NSMutableDictionary *game = [[self.gameDictionaries objectForKey:[NSString stringWithFormat:@"%@", gameType]] mutableCopy];
    
    if ([[game objectForKey:@"bet"] isEqual: [NSNull null]]) {
        if ([[game objectForKey:@"max_bet"] isEqual: [NSNull null]]){
            [game setObject:@"Required bet: 100 or more" forKey:@"bet"];
        } else {
            [game setObject:[NSString stringWithFormat:@"Required bet: %@ - %@",
                                    [game objectForKey:@"min_bet"],
                                    [game objectForKey:@"max_bet"]]
                     forKey:@"bet"];
        }
        [game setObject:@"New Game" forKey:@"button"];
    } else {
        [game setObject:[NSString stringWithFormat:@"Betted: %@", [game objectForKey:@"bet"]] forKey:@"bet"];
        [game setObject:@"Continue" forKey:@"button"];
    }

    return [game copy];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0;
}

@end

