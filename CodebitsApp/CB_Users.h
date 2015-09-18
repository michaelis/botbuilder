//
//  CB_Users.h
//  CodebitsApp
//
//  Created by Miguel Gomes on 18/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CB_Users : NSObject

@property (strong, nonatomic) NSMutableArray *users;

+ (CB_Users *)sharedInstance;

- (void)updateUser:(NSMutableDictionary *)user atIndex:(NSInteger)index;

@end
