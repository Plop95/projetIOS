//
//  MangasViewController.h
//  Manga Scan
//
//  Created by Mohamed Abdelli on 23/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "ChapitreViewController.h"

@interface MangasViewController : UITableViewController<UISearchDisplayDelegate>{
    NSArray *allMangasArray;
    NSArray *searchResults;
}

-(void)wsAllMangas;
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

@end
