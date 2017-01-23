//
//  CollectionViewController.h
//  UICollectionView
//
//  Created by garytan on 2017/1/18.
//  Copyright © 2017年 com.garygenglun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *share;
- (IBAction)share_action:(id)sender;

@end
