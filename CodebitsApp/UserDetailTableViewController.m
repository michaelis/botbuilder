//
//  UserDetailTableViewController.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 17/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "UserDetailTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CB_API.h"
#import "CB_Users.h"

#define MAIN_INFO_CELL_HEIGHT 116
#define MORE_INFO_CELL_HEIGHT 50
#define BIO_CELL_EXTRA_HEIGH 30

@interface UserDetailTableViewController ()
{
    BOOL fullDataAvailable;
    CGFloat userBioCellHeight;
}

@end

static NSString *AVATAR_IMAGE_URL = @"http://www.gravatar.com/avatar/";
//https://codebits.eu/imgs/b/2014/1_big.png

@implementation UserDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    fullDataAvailable = false;
    
#warning TODO take only first name
    self.title = [self.user objectForKey:@"name"];
    
    self.user = [CB_Users sharedInstance].users[self.userIndex];
    
#warning TODO - create CB_User and use instead of NSMutableDictionary
    //test if user has full data by trying to get karma field
    if(![self.user objectForKey:@"karma"]){
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CB_API user:[self.user objectForKey:@"id"]
         
             success:^(NSMutableDictionary *user) {
                 [[CB_Users sharedInstance] updateUser:user atIndex:self.userIndex];
                 self.user = [CB_Users sharedInstance].users[self.userIndex];
                 fullDataAvailable = true;
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                 [self.tableView reloadData];
             }
             failure:^(NSString *error) {
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             }];
    }
    else
        fullDataAvailable = true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(fullDataAvailable)
        return 6;
    else
        return 2;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    switch(indexPath.row)
    {
        case 0:
            return MAIN_INFO_CELL_HEIGHT;
        case 1:
        {
            if(fullDataAvailable)
                return userBioCellHeight;
            else
                return MAIN_INFO_CELL_HEIGHT;
        }
            break;
        default:
            return MORE_INFO_CELL_HEIGHT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Configure the cell...
    switch(indexPath.row)
    {
        case 0:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"MainInfoCell" forIndexPath:indexPath];
            
            UILabel *userNameLabel = (UILabel*)[cell viewWithTag:101];
            userNameLabel.text = [self.user objectForKey:@"name"];
            
            UILabel *userTwitterLabel = (UILabel*)[cell viewWithTag:102];
            userTwitterLabel.text = [NSString stringWithFormat:@"twitter: @%@",[self.user objectForKey:@"twitter"]];
            
            NSString *md5mail = [self.user objectForKey:@"md5mail"];
            NSString *imageUrlStr = [NSString stringWithFormat:@"%@/%@.jpg", AVATAR_IMAGE_URL,md5mail];
            UIImageView *userImageView = (UIImageView*)[cell viewWithTag:100];
            [userImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        }
            break;
        case 1:{
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"MoreInfoCell" forIndexPath:indexPath];
            if(fullDataAvailable){
                cell.textLabel.text = NSLocalizedString(@"QUEM SOU EU?", nil);
                cell.detailTextLabel.text = [self.user objectForKey:@"bio"];
                cell.detailTextLabel.numberOfLines = 300;
                
                CGFloat aLabelSizeWidth = cell.detailTextLabel.frame.size.width;
                UIFont *aLabelFont = [cell.detailTextLabel font];
                CGSize asize = [[NSString stringWithFormat:@"\"%@\"",[self.user objectForKey:@"bio"]] boundingRectWithSize:CGSizeMake(aLabelSizeWidth, MAXFLOAT)
                                                                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                                                                         attributes:@{
                                                                                                                      NSFontAttributeName : aLabelFont
                                                                                                                      }
                                                                                                            context:nil].size;
                
                userBioCellHeight = asize.height + BIO_CELL_EXTRA_HEIGH;
            }
            else{
                cell.textLabel.text = NSLocalizedString(@"A obter dados de utilizador", nil);
                cell.detailTextLabel.text = NSLocalizedString(@"É rápido...", nil);
            }
            
            
        }
            break;
        case 2:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"MoreInfoCell" forIndexPath:indexPath];
            
            cell.textLabel.text = NSLocalizedString(@"PONTOS DE KARMA", nil);
            cell.detailTextLabel.text = [self.user objectForKey:@"karma"];
        }
            break;
        case 3:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"MoreInfoCell" forIndexPath:indexPath];
            
            cell.textLabel.text = NSLocalizedString(@"NICK", nil);
            cell.detailTextLabel.text = [self.user objectForKey:@"nick"];
        }
        case 4:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"MoreInfoCell" forIndexPath:indexPath];
            
            cell.textLabel.text = NSLocalizedString(@"BLOG", nil);
            cell.detailTextLabel.text = [self.user objectForKey:@"blog"];
        }
        case 5:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"MoreInfoCell" forIndexPath:indexPath];
            
            cell.textLabel.text = NSLocalizedString(@"HABILIDADES", nil);
            NSArray *skills = [self.user objectForKey:@"skills"];
            cell.detailTextLabel.text = [[skills valueForKey:@"description"] componentsJoinedByString:@" "];
            cell.detailTextLabel.numberOfLines = 10;
        }
            
        default:
            break;
    }
    
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
