//
//  AOBJSigninViewController.m
//  BJ
//
//  Created by Dili Hu on 5/28/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJSigninViewController.h"
#import "AOBJAuthManager.h"
#import "AOBJHomeViewController.h"

@interface AOBJSigninViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailString;
@property (weak, nonatomic) IBOutlet UITextField *passwordString;
@property(strong) NSDictionary *maybeInfo;
@end

@implementation AOBJSigninViewController
- (IBAction)loginButton:(UIButton *)sender
{
    NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];

    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"http://localhost:3000/csrf.json" parameters:nil success:^(NSURLSessionDataTask *task, id csrfResponse) {
        NSLog(@"%@", [task.response.class description]);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        NSLog(@"%@", httpResponse.allHeaderFields);
        
        NSDictionary *parameters = @{@"email":self.emailString.text,
                                     @"password":self.passwordString.text,
                                     @"authenticity_token" : [httpResponse.allHeaderFields objectForKey:@"X-Csrf-Token"]
                                     };
        
        [manager POST:@"http://localhost:3000/sessions.json" parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  
                  self.maybeInfo = responseObject;
                  
                  for(NSString *key in [self.maybeInfo allKeys]) {
                      NSLog(@"%@ is =%@=", key, [self.maybeInfo objectForKey:key]);
                  }
                  
                  [self performSegueWithIdentifier:@"LoginSuccess" sender:self];
                  
                  //NSHTTPCookie
                  
                  //NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@"http://temp"]];
                  //NSLog(@"How many Cookies: %d", all.count);
                  
                  //NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                  //[cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
                  //NSArray *cookies = [cookieStorage cookies];
                  //NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString: @"http://localhost" ]];
                  
                  //             NSArray *cookieStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:baseURL];
                  //             NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieStorage];
                  //             NSMutableURLRequest *request = [myRequestSerializer serializer];
                  //             for (NSString *key in cookieHeaders) {
                  //                 [request addValue:cookieHeaders[key] forHTTPHeaderField:key];
                  //             }
                  
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving data"
                                                                      message:[error localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Ok"
                                                            otherButtonTitles:nil];
                  alertView.accessibilityLabel = @"connectionError";
                  [alertView show];
              }];
        
        
        ////===
        //    NSHTTPURLResponse   * response;
        //    NSError             * error;
        //    NSMutableURLRequest * request;
        //    request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://temp/gomh/authenticate.py?setCookie=1"]
        //                                            cachePolicy:NSURLRequestReloadIgnoringCacheData
        //                                        timeoutInterval:60] autorelease];
        //
        //    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //    NSLog(@"RESPONSE HEADERS: \n%@", [response allHeaderFields]);
        //
        //    // If you want to get all of the cookies:
        //    NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@"http://temp"]];
        //    NSLog(@"How many Cookies: %d", all.count);
        //    // Store the cookies:
        //    // NSHTTPCookieStorage is a Singleton.
        //    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:all forURL:[NSURL URLWithString:@"http://temp"] mainDocumentURL:nil];
        //
        //    // Now we can print all of the cookies we have:
        //    for (NSHTTPCookie *cookie in all)
        //        NSLog(@"Name: %@ : Value: %@, Expires: %@", cookie.name, cookie.value, cookie.expiresDate);
        //
        //
        //    // Now lets go back the other way.  We want the server to know we have some cookies available:
        //    // this availableCookies array is going to be the same as the 'all' array above.  We could
        //    // have just used the 'all' array, but this shows you how to get the cookies back from the singleton.
        //    NSArray * availableCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://temp"]];
        //    NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies:availableCookies];
        //    
        //    // we are just recycling the original request
        //    [request setAllHTTPHeaderFields:headers];
        //    
        //    request.URL = [NSURL URLWithString:@"http://temp/gomh/authenticate.py"];
        //    error       = nil;
        //    response    = nil;
        //    
        //    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //    NSLog(@"The server saw:\n%@", [[[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding] autorelease]);
        ////===
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LoginSuccess"]) {
        AOBJHomeViewController *vc2 = (AOBJHomeViewController *)segue.destinationViewController;
        vc2.userInfo = self.maybeInfo;
    }
}


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
    // Do any additional setup after loading the view.
}

@end
