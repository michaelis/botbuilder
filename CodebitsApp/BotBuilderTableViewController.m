//
//  BotBuilderTableViewController.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 14/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "BotBuilderTableViewController.h"
#import "CB_API.h"
#import "BotPartsCollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CB_Bot.h"

#define CELL_HEIGHT 44

static NSString *API_URL = @"https://services.sapo.pt/Codebits/";

@interface BotBuilderTableViewController ()
{
    NSArray * menuElements;
    UIImageView *botImageView;
    BOOL needsRefresh;
}

@end

@implementation BotBuilderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = NSLocalizedString(@"Bot Builder", nil);
    menuElements = [self setMenuElements];
    
    [CB_API botParts:^(CB_BotPartsCatalog *parts) {
        
        self.botParts = parts;
        
    } failure:^(NSString *error) {
        
    }];
    
    UIImage *botImage = [self getBotImageView];
    if(botImage)
    {
        botImageView.image = botImage;
    }
    needsRefresh = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if(needsRefresh)
    {
        // Update Bot Image
        UIImage *botImage = [self getBotImageView];
        if(botImage)
        {
            botImageView.image = botImage;
        }
        
        [self.tableView reloadData];
        needsRefresh = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BotPartsCollectionViewController *destination = segue.destinationViewController;
    
    destination.parts = [self partsForIndex:[sender tag]];
    destination.botPartKey = [self keyForIndex:[sender tag]];
    needsRefresh = true;
}

- (NSArray*) partsForIndex:(NSInteger)index
{
    switch(index){
        case 0:
            return self.botParts.body;
            break;
        case 1:
            return self.botParts.bgcolor;
            break;
        case 2:
            return self.botParts.grad;
            break;
        case 3:
            return self.botParts.eyes;
            break;
        case 4:
            return self.botParts.mouth;
            break;
        case 5:
            return self.botParts.legs;
            break;
        case 6:
            return self.botParts.head;
            break;
        case 7:
            return self.botParts.arms;
            break;
        default:
            return nil;
            break;
    }
}

- (NSString*) keyForIndex:(NSInteger)index
{
    switch(index){
        case 0:
            return kCB_Body;
            break;
        case 1:
            return kCB_BgColor;
            break;
        case 2:
            return kCB_Grad;
            break;
        case 3:
            return kCB_Eyes;
            break;
        case 4:
            return kCB_Mouth;
            break;
        case 5:
            return kCB_Legs;
            break;
        case 6:
            return kCB_Head;
            break;
        case 7:
            return kCB_Arms;
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 0)
        return 1;
    else
        return [menuElements count];
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
        return [UIScreen mainScreen].bounds.size.width;
    else
        return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // Configure the cell...
    if(indexPath.section == 0)
    {
        switch(indexPath.row){
            case 0:{
                cell = [tableView dequeueReusableCellWithIdentifier:@"BotImageCell" forIndexPath:indexPath];
                
                UILabel *tutorialText = (UILabel*)[cell viewWithTag:101];
                
                botImageView = (UIImageView*)[cell viewWithTag:100];
                
                UIImage *botImage = [self getBotImageView];
                if(botImage)
                {
                    botImageView.image = botImage;
                    tutorialText.hidden = YES;
                }
                else
                    tutorialText.hidden = NO;
            }
                break;
            default:
                cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell" forIndexPath:indexPath];
                cell.textLabel.text = NSLocalizedString(@"Random Bot", nil);
                break;
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell" forIndexPath:indexPath];
        cell.textLabel.text = menuElements[indexPath.row];
        cell.tag = indexPath.row;
    }
    
    return cell;
}

#pragma mark - internals

- (NSArray*)setMenuElements
{
    NSArray* elements = [NSArray arrayWithObjects:NSLocalizedString(@"Corpo", nil), NSLocalizedString(@"Fundo",nil), NSLocalizedString(@"Gradiente",nil), NSLocalizedString(@"Olhos",nil), NSLocalizedString(@"Boca",nil), NSLocalizedString(@"Pernas",nil), NSLocalizedString(@"Cabeça",nil), NSLocalizedString(@"Braços",nil), nil];
    return elements;
}

- (UIImage*)getBotImageView
{
//    NSArray *partIds = [[NSArray alloc] initWithObjects:@"01",@"00",@"00",@"00",@"00",@"00",@"00",@"00", nil];
//    
//    NSString *partsStr = @"";
//    for(NSString *partId in partIds) {
//        if(![partsStr isEqualToString:@""])
//            partsStr = [partsStr stringByAppendingString:@","];
//        partsStr = [partsStr stringByAppendingString:partId];
//    }
    
    
    NSString *ballonText = @"nada";
    
    NSString *imageUrlStr = [API_URL stringByAppendingString:[NSString stringWithFormat:@"botmake/%@",[CB_Bot sharedInstance].getPartsStr]];
    
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:imageUrlStr]]];
    
    return image;
    
//    UIImageView *returnView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
//    [returnView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]
//                    placeholderImage:nil];
//    return returnView;//[UIImage imageNamed:@"first"];
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
