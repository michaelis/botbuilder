//
//  CodebitsAPI.h
//  CodebitsApp
//
//  Created by Miguel Gomes on 14/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "CB_BotPartsCatalog.h"

@interface CB_API : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

+ (CB_API *)sharedInstance;

+ (void)botParts:(void (^)(CB_BotPartsCatalog *parts))sucess
         failure:(void (^)(NSString *error))failure;

@end
