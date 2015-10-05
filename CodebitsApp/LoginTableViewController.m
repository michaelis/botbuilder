//
//  LoginTableViewController.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 18/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "LoginTableViewController.h"
#import "CB_API.h"
#import "CB_Users.h"

@interface LoginTableViewController ()
{
    NSString *email;
    NSString *password;
    BOOL loginFailed;
}

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"Login", nil);
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    
    self.navigationItem.rightBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Selectors

- (void)cancelPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (loginFailed) {
        return NSLocalizedString(@"Login falhou", nil);
    }
    else
        return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Configure the cell...
    switch(indexPath.row)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell" forIndexPath:indexPath];

            UITextField *mailField = (UITextField*)[cell viewWithTag:100];
            mailField.placeholder = @"mail";
            
            [mailField addTarget:self action:@selector(mailChanged:) forControlEvents:UIControlEventEditingChanged];
        }break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell" forIndexPath:indexPath];
            
            UITextField *passwdField = (UITextField*)[cell viewWithTag:100];
            passwdField.placeholder = @"password";
            
            [passwdField addTarget:self action:@selector(passwordChanged:) forControlEvents:UIControlEventEditingChanged];
            
        }break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"LoginCell" forIndexPath:indexPath];
            cell.textLabel.text = NSLocalizedString(@"Login", nil);
        }
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        loginFailed = false;
        [self.tableView reloadData];
        
        if([[CB_Users sharedInstance].users count] == 0)
        {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CB_API getToken:email password:password
                     success:^(NSString *token) {
                         
                         [CB_API users:^(NSArray *users) {
                             if ([users isKindOfClass:[NSArray class]]){
                             
                                 [CB_Users sharedInstance].users = [NSMutableArray arrayWithArray:users];
                                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }
                             else{
                                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                 loginFailed = YES;
                                 [self.tableView reloadData];
                             }
                          
                         } failure:^(NSString *error) {
                             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
                         
                     } failure:^(NSError *error) {
                         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                         [self dismissViewControllerAnimated:YES completion:nil];
                     }];
        }
    }
}

#pragma mark - selectors
- (void) mailChanged:(id)sender {
    email = [(UITextField*)sender text];
}

- (void) passwordChanged:(id)sender {
    password = [(UITextField*)sender text];
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
