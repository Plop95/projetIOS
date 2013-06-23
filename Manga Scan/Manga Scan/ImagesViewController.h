//
//  ImagesViewController.h
//  Manga Scan
//
//  Created by Mohamed Abdelli on 23/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface ImagesViewController : UIViewController{
    NSArray *imgArray;
    NSMutableDictionary *imagesDictionary;
    float lastScaleFactor;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property(strong,nonatomic)NSString* chapitreID;
@property(strong,nonatomic)NSString* numChap;

-(void)wsAllImages;
-(void)afficheAsyncImageFromURL:(NSString*)url;

@end
