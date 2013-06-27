//
//  Manga.h
//  Manga Scan
//
//  Created by Mohamed Abdelli on 27/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Manga : NSManagedObject

@property (nonatomic, retain) NSString * mangaID;
@property (nonatomic, retain) NSString * mangaName;

@end
