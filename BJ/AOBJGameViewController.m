//
//  AOBJGameViewController.m
//  BJ
//
//  Created by Dili Hu on 6/3/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJGameViewController.h"
#import "AOBJHelper.h"

static NSString *const dealerEmail = @"dealer@dealer.dealer";

@interface AOBJGameViewController ()
@property (strong, nonatomic) NSDictionary *user;
@property (strong, nonatomic) NSDictionary *game;

@property (weak, nonatomic) IBOutlet UILabel *tableName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *userChips;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *gameTitle;
@property (weak, nonatomic) IBOutlet UIImageView *dealerImage;
@property (weak, nonatomic) IBOutlet UIButton *betButton;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleButton;
@property (weak, nonatomic) IBOutlet UITextField *betTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealerHandLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerHandLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextGameButton;

@end

@implementation AOBJGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"the game info %@", self.gameInfo);
    
    [self updateView];
}


- (void) updateView {
    self.game = [self.gameInfo objectForKey:@"game"];
    self.user = [self.gameInfo objectForKey:@"user"];
    
    self.gameTitle.text = [self.game objectForKey:@"game_type"];
    self.userName.text = [self.user objectForKey:@"name"];
    self.userChips.text = [NSString stringWithFormat:@"Chips: %@", [self.user objectForKey:@"chips"]];
    self.userLevel.text = [NSString stringWithFormat:@"Level: %@",
                           [AOBJHelper levelByChips:[self.user objectForKey:@"chips"]]];
    [AOBJHelper setImageFor:self.userImage useEmail:[self.user objectForKey:@"email"]];
    [AOBJHelper setImageFor:self.dealerImage useEmail:dealerEmail];
    
    [self showHand:@"dealer_hand" withLabel:self.dealerHandLabel];
    [self showHand:@"player_hand" withLabel:self.playerHandLabel];
    
    NSString *status = [self.gameInfo objectForKey:@"status"];
    if ([status isEqualToString:@"bet"]) {
        [self enableBet:true];
        self.hitButton.enabled = false;
        self.standButton.enabled = false;
        self.doubleButton.enabled = false;
    } else if ([status isEqualToString:@"init"]) {
        [self enableBet:false];
        self.hitButton.enabled = true;
        self.standButton.enabled = true;
        self.doubleButton.enabled = true;
    } else if ([status isEqualToString:@"hit"]) {
        self.doubleButton.enabled = false;
        [self enableBet:false];
    } else {
        self.resultLabel.text = status;
        self.nextGameButton.enabled = true;
        self.nextGameButton.hidden = false;
    }
}


- (IBAction)newGameButtonTapped:(id)sender{
    AOBJHTTPClient *client = [AOBJHTTPClient sharedAOBJHTTPClient];
    [client updateGame:[self.game valueForKey:@"id"]
             forPlayer:[self.game valueForKey:@"user_id"]
            withAction:@"New Game"
                thenDo:^(NSURLSessionDataTask *task, id responseObject) {
                    self.gameInfo = responseObject;
                    [self updateView];
                }];
    self.resultLabel.text = @"";
    self.nextGameButton.enabled = false;
    self.nextGameButton.hidden = true;
}


-(void) enableBet:(Boolean)enable {
    self.betButton.enabled = enable;
    self.betTextField.text = [NSString stringWithFormat:@"%@", [self.game objectForKey:@"bet"]];
    self.betTextField.enabled = enable;
}

- (void) showHand:(NSString *)handName withLabel:(UILabel *)label {
    NSMutableString *hand = [[NSMutableString alloc] init];
    for (NSDictionary *card in [self.gameInfo objectForKey:handName]) {
        [hand appendString:[NSString stringWithFormat:@" %@%@ ", [card objectForKey:@"rank"], [card objectForKey:@"suit"]]];
    }
    label.text = hand;
}

- (IBAction)betButtonTapped:(UIButton *)sender {
    
    if ([self notValidBet]) return;
        
    AOBJHTTPClient *client = [AOBJHTTPClient sharedAOBJHTTPClient];
    [client updateGame:[self.game valueForKey:@"id"]
             forPlayer:[self.game valueForKey:@"user_id"]
               withBet:[self.betTextField.text integerValue]
                thenDo:^(NSURLSessionDataTask *task, id responseObject) {
                    self.gameInfo = responseObject;
                    [self updateView];
                }];
}


- (IBAction)hitButtonTapped:(UIButton *)sender {
    AOBJHTTPClient *client = [AOBJHTTPClient sharedAOBJHTTPClient];
    [client updateGame:[self.game valueForKey:@"id"]
             forPlayer:[self.game valueForKey:@"user_id"]
            withAction:@"Hit"
                thenDo:^(NSURLSessionDataTask *task, id responseObject) {
                    self.gameInfo = responseObject;
                    [self updateView];
                }];
}


- (IBAction)standButtonTapped:(UIButton *)sender {
    AOBJHTTPClient *client = [AOBJHTTPClient sharedAOBJHTTPClient];
    [client updateGame:[self.game valueForKey:@"id"]
             forPlayer:[self.game valueForKey:@"user_id"]
            withAction:@"Stand"
                thenDo:^(NSURLSessionDataTask *task, id responseObject) {
                    self.gameInfo = responseObject;
                    [self updateView];
                }];
}


- (IBAction)doubleButtonTapped:(UIButton *)sender {
    AOBJHTTPClient *client = [AOBJHTTPClient sharedAOBJHTTPClient];
    [client updateGame:[self.game valueForKey:@"id"]
             forPlayer:[self.game valueForKey:@"user_id"]
            withAction:@"Double"
                thenDo:^(NSURLSessionDataTask *task, id responseObject) {
                    self.gameInfo = responseObject;
                    [self updateView];
                }];
}


- (Boolean) notValidBet {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([self.betTextField.text rangeOfCharacterFromSet:notDigits].location != NSNotFound)
    {
        [AOBJHelper showMesssge:@"Your bet amount can only be an interger."];
        return true;
    }
    
    int bet = [self.betTextField.text integerValue];
    
    if (bet > [[self.user valueForKey:@"chips"] intValue]) {
        [AOBJHelper showMesssge:@"You can not bet more chips than you have."];
        return true;
    }
    
    
    // needwork
    if (bet < 10) {
        [AOBJHelper showMesssge:[NSString stringWithFormat:@"The minimum bet at this table is %@.", @10]];
        return true;
    }
    
    return false;
}
         
         
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
