//
//  AOBJHTTPClient.h
//  BJ
//
//  Created by Dili Hu on 6/10/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol AOBJHTTPClientDelegate;

@interface AOBJHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<AOBJHTTPClientDelegate>delegate;

+ (AOBJHTTPClient *)sharedAOBJHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)updateGame:(NSNumber *)game forPlayer:(NSNumber *)player withAction:(NSString *)action
                thenDo:(void (^)(NSURLSessionDataTask *task, id responseObject))todo;
- (void)updateGame:(NSNumber *)game forPlayer:(NSNumber *)player withBet:(int)bet
            thenDo:(void (^)(NSURLSessionDataTask *task, id responseObject)) todo;
@end


@protocol AOBJHTTPClientDelegate <NSObject>
@optional

-(void)AOBJHTTPClient:(AOBJHTTPClient *)client didUpdateWithStat:(id)stat;
-(void)AOBJHTTPClient:(AOBJHTTPClient *)client didFailWithError:(NSError *)error;

@end
