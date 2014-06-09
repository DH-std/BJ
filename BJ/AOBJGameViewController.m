//
//  AOBJGameViewController.m
//  BJ
//
//  Created by Dili Hu on 6/3/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJGameViewController.h"
#import "AOBJHelper.h"

@interface AOBJGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tableName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;
@property (weak, nonatomic) IBOutlet UILabel *userChips;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UISlider *betSlider;

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

    self.tableName.text = [[self.gameInfo objectForKey:@"game"] objectForKey:@"game_type"];
    self.userName.text = [self.gameInfo objectForKey:@"name"];
    self.userChips.text = [NSString stringWithFormat:@"Chips: %@", [self.gameInfo objectForKey:@"chips"]];
    self.userLevel.text = [NSString stringWithFormat:@"Level: %@",
                           [AOBJHelper levelByChips:[self.gameInfo objectForKey:@"chips"]]];
    [AOBJHelper setImageFor:self.userImage useEmail:[self.gameInfo objectForKey:@"email"]];
    
    if ([self.tableName.text isEqual: @"High Roller"]) {
        self.betSlider.minimumValue = 100;
        self.betSlider.maximumValue = [[self.gameInfo objectForKey:@"chips"] floatValue];
        // self.betSlider.
    }
    
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
