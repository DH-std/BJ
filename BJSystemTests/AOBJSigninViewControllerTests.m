//
//  AOBJSigninViewControllerTests.m
//  
//
//  Created by Dili Hu on 5/28/14.
//
//

#import "KIF/KIF.h"
#import <XCTest/XCTest.h>
#import "KIFUITestActor+AOBJChecker.h"
#import "AOBJHomeViewController.h"

@interface AOBJSigninViewControllerTests : KIFTestCase

@end

@implementation AOBJSigninViewControllerTests

//- (void)setUp
//{
//    [super setUp];
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//- (void)tearDown
//{
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//    [super tearDown];
//}
//

- (void)testLoginPage
{
    // elements existence
    [tester waitForTappableViewWithAccessibilityLabel:@"loginButton"];
    [tester waitForViewWithAccessibilityLabel:@"userEmailTextField"];
    [tester waitForViewWithAccessibilityLabel:@"userPasswordTextField"];
    
    // invalid login
    [tester tapViewWithAccessibilityLabel:@"loginButton"];
    [tester waitForViewWithAccessibilityLabel:@"Error Retrieving data"];
    [tester tapViewWithAccessibilityLabel:@"Ok"];
    [tester enterText:@"sally@example.com" intoViewWithAccessibilityLabel:@"userEmailTextField"];
    [tester tapViewWithAccessibilityLabel:@"loginButton"];
    [tester waitForViewWithAccessibilityLabel:@"Error Retrieving data"];
    [tester tapViewWithAccessibilityLabel:@"Ok"];
    
    // valid login
    [tester enterText:@"foobar" intoViewWithAccessibilityLabel:@"userPasswordTextField"];
    [tester tapViewWithAccessibilityLabel:@"Hide keyboard"];
    [tester tapViewWithAccessibilityLabel:@"loginButton"];
    // home page elements
    [tester waitForViewWithAccessibilityLabel:@"userName"];
    [tester waitForViewWithAccessibilityLabel:@"userLevel"];
    [tester waitForViewWithAccessibilityLabel:@"userChips"];

    // validate segue data passed into home
//    AOBJHomeViewController *homeVc = (AOBJHomeViewController *)[tester currentViewController];
//    NSDictionary *expected = @{@"id" : @1, @"name" : @"Sally", @"email" : @"sally@example.com", @"chips" : @100, @"games" : @"[]"};
//    XCTAssertTrue([homeVc.userInfo isEqual:expected], @"home view controller is passed the user data");
    
    // sign out from home page
    [tester waitForViewWithAccessibilityLabel:@"logoutButton"];
//    [tester tapViewWithAccessibilityLabel:@"logoutButton"];
//    [tester waitForTappableViewWithAccessibilityLabel:@"loginButton"];

}

@end

