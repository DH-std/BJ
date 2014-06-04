//
//  AOBJHomeViewController.h
//  BJ
//
//  Created by Dili Hu on 5/27/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOBJHomeViewController : UIViewController
@property(strong) NSMutableDictionary *userInfo;

- (IBAction)logoutButtonTapped:(UIButton *)sender;
@end
