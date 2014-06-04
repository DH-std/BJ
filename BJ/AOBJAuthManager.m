//
//  AOBJAuthManager.m
//  BJ
//
//  Created by Dili Hu on 5/29/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJAuthManager.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation AOBJAuthManager
#pragma mark - Methods

- (void)setUsername:(NSString *)username andPassword:(NSString *)password
{
    [self.requestSerializer clearAuthorizationHeader];
    [self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
        return nil;
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

#pragma mark - Singleton Methods

+ (AOBJAuthManager *)sharedManager
{
    static dispatch_once_t pred;
    static AOBJAuthManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{ _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:3000"]]; });
    // You should probably make this a constant somewhere
    return _sharedManager;
}
@end
