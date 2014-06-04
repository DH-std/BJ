//
//  AOBJAuthManager.h
//  BJ
//
//  Created by Dili Hu on 5/29/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AOBJAuthManager : AFHTTPRequestOperationManager

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

+ (AOBJAuthManager *)sharedManager;

@end
