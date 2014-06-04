//
//  KIFUITestActor+AOBJChecker.m
//  BJ
//
//  Created by Dili Hu on 5/29/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "KIFUITestActor+AOBJChecker.h"

@implementation KIFUITestActor (AOBJChecker)

- (UIViewController *) currentViewController {
    UINavigationController *navController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    return [navController topViewController];
}

@end
