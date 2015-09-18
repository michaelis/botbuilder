//
//  CB_Users.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 18/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "CB_Users.h"

@implementation CB_Users


#pragma mark - Singleton

+ (CB_Users *)sharedInstance
{
    static CB_Users *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CB_Users new];
        
        sharedInstance.users = [[NSMutableArray alloc] init];
    });
    return sharedInstance;
}

- (void)updateUser:(NSMutableDictionary *)user atIndex:(NSInteger)index {
    
    self.users[index] = user;
}

@end
