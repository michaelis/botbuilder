//
//  CB_Bot.h
//  CodebitsApp
//
//  Created by Miguel Gomes on 15/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CB_Bot : NSObject

@property (nonatomic, strong) NSMutableDictionary *parts;

+ (CB_Bot *)sharedInstance;
- (NSString *)getPartsStr;

@end
