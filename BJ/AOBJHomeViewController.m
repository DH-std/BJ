//
//  AOBJHomeViewController.m
//  BJ
//
//  Created by Dili Hu on 5/27/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJHomeViewController.h"

@interface AOBJHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@end

@implementation AOBJHomeViewController
- (IBAction)buttonTapped:(UIButton *)sender {
    NSLog(@"Hello~~");
    self.wasTapped = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wasTapped = NO;
    // Do any additional setup after loading the view.
}

@end
