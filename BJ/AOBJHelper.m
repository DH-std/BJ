//
//  AOBJHelper.m
//  BJ
//
//  Created by Dili Hu on 6/4/14.
//  Copyright (c) 2014 AO. All rights reserved.
//

#import "AOBJHelper.h"

@implementation AOBJHelper

+ (NSString *) levelByChips:(NSString *) chips {
    int level = ([chips intValue] + 99) / 100;
    return [NSString stringWithFormat:@"%d", level];
}

@end
