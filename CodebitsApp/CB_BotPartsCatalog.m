//
//  CB_BotParts.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 15/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "CB_BotPartsCatalog.h"

//NSString *const kCB_Arms = @"arms";
//NSString *const kCB_BgColor = @"bgcolor";
//NSString *const kCB_Body = @"body";
//NSString *const kCB_Eyes = @"eyes";
//NSString *const kCB_Grad = @"grad";
//NSString *const kCB_Head = @"head";
//NSString *const kCB_Legs = @"legs";
//NSString *const kCB_Mouth = @"mouth";

@implementation CB_BotPartsCatalog

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    self.arms = [dict objectForKey:kCB_Arms];
    self.bgcolor = [dict objectForKey:kCB_BgColor];
    self.body = [dict objectForKey:kCB_Body];
    self.eyes = [dict objectForKey:kCB_Eyes];
    self.grad = [dict objectForKey:kCB_Grad];
    self.head = [dict objectForKey:kCB_Head];
    self.legs = [dict objectForKey:kCB_Legs];
    self.mouth = [dict objectForKey:kCB_Mouth];
    
    return self;
}

@end
