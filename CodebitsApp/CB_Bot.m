//
//  CB_Bot.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 15/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "CB_Bot.h"
#import "CB_BotPartsCatalog.h"

@implementation CB_Bot

+ (CB_Bot *)sharedInstance
{
    static CB_Bot *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CB_Bot new];
        
        sharedInstance.parts = [[NSMutableDictionary alloc]
                                initWithObjects:[[NSArray alloc] initWithObjects:@"01",@"00",@"00",@"00",@"00",@"00",@"00",@"00", nil]
                                forKeys:[[NSArray alloc] initWithObjects:kCB_Body,kCB_BgColor,kCB_Grad,kCB_Eyes,kCB_Mouth,kCB_Legs,kCB_Head,kCB_Arms,nil]];
        
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Body];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_BgColor];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Grad];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Eyes];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Mouth];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Legs];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Head];
//        [sharedInstance.parts setValue:@"00" forKey:kCB_Arms];
    });
    return sharedInstance;
}

- (NSString *)getPartsStr {
    
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",
            [self.parts objectForKey:kCB_Body],[self.parts objectForKey:kCB_BgColor],
            [self.parts objectForKey:kCB_Grad],[self.parts objectForKey:kCB_Eyes],
            [self.parts objectForKey:kCB_Mouth],[self.parts objectForKey:kCB_Legs],
            [self.parts objectForKey:kCB_Head],[self.parts objectForKey:kCB_Arms]];
}

@end
