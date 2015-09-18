//
//  UserDetailTableViewController.h
//  CodebitsApp
//
//  Created by Miguel Gomes on 17/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *user;
@property NSInteger userIndex;

@end
