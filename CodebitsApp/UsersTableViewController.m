//
//  UsersTableViewController.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 14/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "UsersTableViewController.h"
#import "CB_API.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserDetailTableViewController.h"
#import "CB_Users.h"
#include "LoginTableViewController.h"

@interface UsersTableViewController ()

@end

static NSString *AVATAR_IMAGE_URL = @"http://www.gravatar.com/avatar/";

@implementation UsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"Utilizadores", nil);
    
#warning TODO show login popup instead of hardcode user data
    if([[CB_Users sharedInstance].users count] == 0)
    {
        LoginTableViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }
    
//    NSString *email = @"miguel.d.gomes@gmail.com";
//    NSString *password = @"DM9HvQL4";
//    
//    if([[CB_Users sharedInstance].users count] == 0)
//    {
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//        [CB_API getToken:email password:password
//                 success:^(NSString *token) {
//                     
//                     [CB_API users:^(NSArray *users) {
//                         [CB_Users sharedInstance].users = [NSMutableArray arrayWithArray:users];
//                         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                         [self.tableView reloadData];
//     
//                     } failure:^(NSString *error) {
//                         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                     }];
//                     
//                 } failure:^(NSError *error) {
//                 
//                 }];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserDetailTableViewController *destination = segue.destinationViewController;
    
    destination.user = [CB_Users sharedInstance].users[[sender tag]];
    destination.userIndex = [sender tag];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if([[CB_Users sharedInstance].users count]>0)
        return 1;
    else
    {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = NSLocalizedString(@"É necessário fazer login para ver lista de utilizadores", nil);
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"System" size:25];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[CB_Users sharedInstance].users count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *md5mail = [[CB_Users sharedInstance].users[indexPath.row] objectForKey:@"md5mail"];
    
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@/%@.jpg", AVATAR_IMAGE_URL,md5mail];
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    //[botPartView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:nil];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text = [[CB_Users sharedInstance].users[indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"twitter: @%@",[[CB_Users sharedInstance].users[indexPath.row] objectForKey:@"twitter"] ];
    cell.tag = indexPath.row;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
