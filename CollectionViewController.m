//
//  CollectionViewController.m
//  UICollectionView
//
//  Created by garytan on 2017/1/18.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionReusableView.h"
#import <Social/Social.h>

@interface CollectionViewController (){
    NSArray *image;
    NSMutableArray *select_images;
}

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    NSArray *first=[NSArray arrayWithObjects:@"angry_birds_cake.jpg",@"creme_brelee.jpg", nil];
    NSArray *second=[NSArray arrayWithObjects:@"egg_benedict.jpg",@"green_tea.jpg", nil];
    image=[NSArray arrayWithObjects:first,second, nil];
    select_images=[NSMutableArray array];
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
#warning Incomplete implementation, return the number of sections
    return [image count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return [[image objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundView=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"photo_frame.png"]];
    cell.selectedBackgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_frame_selected.png"]];
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:100];
    imageView.image=[UIImage imageNamed:[image [indexPath.section]objectAtIndex:indexPath.row]];
    self.collectionView.allowsMultipleSelection=YES;
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView=nil;
    if(kind== UICollectionElementKindSectionHeader){
        CollectionReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title=[[NSString alloc] initWithFormat:@"Group %li",indexPath.section+1];
        headerView.title.text=title;
        reusableView=headerView;
    }
    if(kind==UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableView=footerView;
    }
    return  reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
        NSString *imagename=[image [indexPath.section]objectAtIndex:indexPath.row];
        [select_images addObject:imagename];
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
        NSString *imagename=[image [indexPath.section] objectAtIndex:indexPath.row];
        [select_images removeObject:imagename];
    
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

- (IBAction)share_action:(id)sender {
    if([select_images count]>0){
            if(![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
                SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [fbController setInitialText:@"Check out the photo"];
                for(NSString *Photo in select_images){
                    [fbController addImage:[UIImage imageNamed:Photo]];
                }
                [self presentViewController:fbController animated:YES completion:Nil];
            }
        for(NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems){
            [self. collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        [select_images removeAllObjects];
        [self.share setStyle:UIBarButtonItemStylePlain];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"You haven't select the photo"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil,nil];
        [alert show];
}
    
   
}
@end
