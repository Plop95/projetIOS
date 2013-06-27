//
//  MangaFavorisViewController.h
//  Manga Scan
//
//  Created by Mohamed Abdelli on 27/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Manga.h"
#import "ChapitreViewController.h"

@interface MangaFavorisViewController : UITableViewController{
    NSMutableArray *arrayFavoris;
}

-(void)editButton;

@end
