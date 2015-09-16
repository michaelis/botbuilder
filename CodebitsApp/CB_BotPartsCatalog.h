//
//  CB_BotParts.h
//  CodebitsApp
//
//  Created by Miguel Gomes on 15/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCB_Arms @"arms"
#define kCB_BgColor @"bgcolor"
#define kCB_Body @"body"
#define kCB_Eyes @"eyes"
#define kCB_Grad @"grad"
#define kCB_Head @"head"
#define kCB_Legs @"legs"
#define kCB_Mouth @"mouth"

@interface CB_BotPartsCatalog : NSObject

@property (nonatomic, strong) NSArray *arms;
@property (nonatomic, strong) NSArray *bgcolor;
@property (nonatomic, strong) NSArray *body;
@property (nonatomic, strong) NSArray *eyes;
@property (nonatomic, strong) NSArray *grad;
@property (nonatomic, strong) NSArray *head;
@property (nonatomic, strong) NSArray *legs;
@property (nonatomic, strong) NSArray *mouth;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
