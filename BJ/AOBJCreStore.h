//
//  AOBJCreStore.h
//  BJ
//
//  Created by Dili Hu on 5/29/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOBJCreStore : NSObject

- (BOOL)isLoggedIn;
- (void)clearSavedCredentials;
- (NSString *)authToken;
- (void)setAuthToken:(NSString *)authToken;

@end
