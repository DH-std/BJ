//
//  AOBJGameViewController.h
//  BJ
//
//  Created by Dili Hu on 6/3/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOBJHTTPClient.h"

@interface AOBJGameViewController : UIViewController <AOBJHTTPClientDelegate>
@property (strong, nonatomic) NSDictionary *gameInfo;

@end
