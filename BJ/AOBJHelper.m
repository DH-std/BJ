//
//  AOBJHelper.m
//  BJ
//
//  Created by Dili Hu on 6/4/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJHelper.h"
#import "UIImageView+KHGravatar.h"

@implementation AOBJHelper

+ (NSString *) levelByChips:(NSString *) chips {
    int level = ([chips intValue] + 99) / 100;
    return [NSString stringWithFormat:@"%d", level];
}

+ (void) setImageFor:(UIImageView *) imageView useEmail:(NSString *) email {
    [imageView setImageWithGravatarEmailAddress:email
                                    placeholderImage:nil
                                    defaultImageType:KHGravatarDefaultImageIdenticon
                                        forceDefault:YES
                                              rating:KHGravatarRatingG];
}

+ (void) showMesssge:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:msg
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
    [alertView show];
}

//+ (void) requestTo:(NSString *)path withParams:(NSDictionary *)params {
//    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
//
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [manager GET:@"http://localhost:3000/csrf.json" parameters:nil success:^(NSURLSessionDataTask *task, id csrfResponse) {
//        NSLog(@"%@", [task.response.class description]);
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
//        NSLog(@"%@", httpResponse.allHeaderFields);
//        
//        NSDictionary *parameters = @{@"email":self.emailString.text,
//                                     @"password":self.passwordString.text,
//                                     @"authenticity_token" : [httpResponse.allHeaderFields objectForKey:@"X-Csrf-Token"]
//                                     };
//        
//        [manager POST:@"http://localhost:3000/sessions.json" parameters:parameters
//              success:^(NSURLSessionDataTask *task, id responseObject) {
//                  
//                  self.maybeInfo = responseObject;
//                  
//                  for(NSString *key in [self.maybeInfo allKeys]) {
//                      NSLog(@"%@ is =%@=", key, [self.maybeInfo objectForKey:key]);
//                  }
//                  
//                  NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                  [defaults setObject: cookiesData forKey: @"sessionCookies"];
//                  [defaults synchronize];
//                  
//                  // NSLog([cookiesData]);
//                  
//                  [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
//                  
//              } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
//                                                                      message:[error localizedDescription]
//                                                                     delegate:nil
//                                                            cancelButtonTitle:@"Ok"
//                                                            otherButtonTitles:nil];
//                  alertView.accessibilityLabel = @"connectionError";
//                  [alertView show];
//              }];
//    } failure:nil];
//    
//
//}

//- (NSURLSessionDataTask *)GET:(NSString *)URLString
//                   parameters:(id)parameters
//                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
//{
//    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
//    
//    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//        if (error) {
//            if (failure) {
//                failure(task, error);
//            }
//        } else {
//            if (success) {
//                success(task, responseObject);
//            }
//        }
//    }];
//    
//    [task resume];
//    
//    return task;
//}


@end
