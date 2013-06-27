//
//  ImagesViewController.h
//  Manga Scan
//
//  Created by Mohamed Abdelli on 23/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface ImagesViewController : UIViewController<UIScrollViewDelegate>{
    NSArray *imgArray;
    NSMutableDictionary *imagesDictionary;
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property(strong,nonatomic)NSString* chapitreID;
@property(strong,nonatomic)NSString* numChap;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

-(void)wsAllImages;
-(void)afficheAsyncImageFromURL:(NSString*)url;
-(void)tapScrollView:(UITapGestureRecognizer*)gesture;

@end
