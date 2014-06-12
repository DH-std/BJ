//
//  AOBJHTTPClient.m
//  BJ
//
//  Created by Dili Hu on 6/10/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJHTTPClient.h"

static NSString * const webURLString = @"http://localhost:3000/";

@implementation AOBJHTTPClient

+ (AOBJHTTPClient *)sharedAOBJHTTPClient{
    static AOBJHTTPClient *_sharedAOBJHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAOBJHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:webURLString]];
    });
    
    return _sharedAOBJHTTPClient;
}


- (instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    
    if(self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


// gameStat needs id(user), game_id, and action
- (void)updateGame:(NSNumber *)game forPlayer:(NSNumber *)player withAction:(NSString *)action
                thenDo:(void (^)(NSURLSessionDataTask *task, id responseObject)) todo {
    NSDictionary *gameStat = @{@"id":player, @"game_id":game, @"move":action};
    
    [self GET:@"playgame" parameters:gameStat
      success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"12345 ====== %@", responseObject);
        todo(task, responseObject);
          
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self handleFailure:error];
    }];
}

- (void)updateGame:(NSNumber *)game forPlayer:(NSNumber *)player withBet:(int)bet
            thenDo:(void (^)(NSURLSessionDataTask *task, id responseObject)) todo {
    NSDictionary *gameStat = @{@"id":player, @"game_id":game, @"move":@"Bet", @"bet":[NSNumber numberWithInt:bet]};
    
    [self GET:@"playgame" parameters:gameStat
      success:^(NSURLSessionDataTask *task, id responseObject) {
          NSLog(@"12345 ====== %@", responseObject);
          todo(task, responseObject);
          
      } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [self handleFailure:error];
      }];
}

- (void) handleFailure:(NSError *)error {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Connection Error"
                              message:[error localizedDescription]
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
    [alertView show];
}
@end
