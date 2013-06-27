//
//  ChapitreViewController.h
//  Manga Scan
//
//  Created by Mohamed Abdelli on 23/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionViewCell.h"
#import "Constant.h"
#import "ImagesViewController.h"
#import "AppDelegate.h"
#import "Manga.h"

@interface ChapitreViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>{
    NSArray *chapitreArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@property(strong,nonatomic)NSString *mangaID;
@property(strong,nonatomic)NSString *mangaName;

-(void)wsAllChapitres;
-(void)addToFavorite;

@end
