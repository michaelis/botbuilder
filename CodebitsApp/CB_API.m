//
//  CodebitsAPI.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 14/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "CB_API.h"

static NSString *API_URL = @"https://services.sapo.pt/Codebits/";

@implementation CB_API

#pragma mark - Singleton

+ (CB_API *)sharedInstance
{
    static CB_API *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CB_API new];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
        //[manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [VVSessionManager sharedManager].login.userToken] forHTTPHeaderField:@"Authorization"];
        
        sharedInstance.manager = manager;
    });
    return sharedInstance;
}

#pragma mark - Bot builder

+ (void)botParts:(void (^)(CB_BotPartsCatalog *parts))sucess
         failure:(void (^)(NSString *error))failure
{
    NSString *url = [API_URL stringByAppendingString:@"botparts"];
    
    AFHTTPRequestOperationManager *manager = [CB_API sharedInstance].manager;
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject){

             CB_BotPartsCatalog *result = [[CB_BotPartsCatalog alloc] initWithDictionary:responseObject];
             
             if(sucess) return sucess(result);
         }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         }];
}

//+ (void)makeBot:(NSArray *)partIds
//     ballonText:(NSString *)ballonText
//        success:(void (^)(UIImageView *botImage))success
//        failure:(void (^)(NSString *error))failure
//{
//    NSString *partsStr;
//    for(NSString *partId in partIds) {
//        partsStr = [partsStr stringByAppendingString:partId];
//    }
//        
//    NSString *url = [API_URL stringByAppendingString:[NSString stringWithFormat:@"botmake/%@,%@",partsStr,ballonText]];
//    
//    [manager GET:url
//      parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject){
//             
//             UIImageView *botImage;
//             
//             if(success) return success(botImage);
//         }
//     
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//     }
//     ];
//}

@end
