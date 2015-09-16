//
//  BotPartsCollectionViewController.m
//  CodebitsApp
//
//  Created by Miguel Gomes on 14/09/15.
//  Copyright (c) 2015 Miguel Gomes. All rights reserved.
//

#import "BotPartsCollectionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CB_Bot.h"
#import "CB_BotPartsCatalog.h"

@interface BotPartsCollectionViewController ()

@end

static NSString *API_IMAGE_URL = @"https://codebits.eu";
NSString *const kCB_Picker = @"picker";

@implementation BotPartsCollectionViewController

static NSString * const reuseIdentifier = @"BotPartCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.parts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImageView *botPartView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    NSDictionary *part = self.parts[indexPath.row];
    
    
    NSString *imageUrlStr = [API_IMAGE_URL stringByAppendingString:[part objectForKey:kCB_Picker]];
    
    // Here we use the new provided sd_setImageWithURL: method to load the web image
    [botPartView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]
                      placeholderImage:nil];
    
    [cell.contentView addSubview:botPartView];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 10) {
        //[[CB_Bot sharedInstance].parts setValue:[NSString stringWithFormat:@"0%li",(long)indexPath.row] forKey:self.botPartKey];
        [[CB_Bot sharedInstance].parts setObject:[NSString stringWithFormat:@"0%li",(long)indexPath.row+1] forKey:self.botPartKey];
    }
    else{
        //[[CB_Bot sharedInstance].parts setValue:[NSString stringWithFormat:@"%li",(long)indexPath.row] forKey:self.botPartKey];
        [[CB_Bot sharedInstance].parts setObject:[NSString stringWithFormat:@"%li",(long)indexPath.row+1] forKey:self.botPartKey];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
