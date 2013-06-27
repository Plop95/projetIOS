//
//  MangaFavorisViewController.m
//  Manga Scan
//
//  Created by Mohamed Abdelli on 27/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import "MangaFavorisViewController.h"

@implementation MangaFavorisViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButton)];
    
    NSManagedObjectContext* context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Manga" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSArray *arrayInter = [context executeFetchRequest:fetchRequest error:nil];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mangaName" ascending:YES];
    arrayInter = [arrayInter sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    arrayFavoris = [[NSMutableArray alloc] initWithArray:arrayInter];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrayFavoris.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = ((Manga*)[arrayFavoris objectAtIndex:indexPath.row]).mangaName;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSManagedObjectContext* context = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;

    [context deleteObject:(Manga*)[arrayFavoris objectAtIndex:indexPath.row]];
    
    [context save:nil];
    
    [arrayFavoris removeObjectAtIndex:indexPath.row];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChapitreViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChapitreViewController"];

    controller.mangaID=((Manga*)[arrayFavoris objectAtIndex:indexPath.row]).mangaID;
    controller.mangaName=((Manga*)[arrayFavoris objectAtIndex:indexPath.row]).mangaName;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)editButton{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Done"]) {
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
        [self.tableView setEditing:NO animated:YES];
        
    }else{
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
        [self.tableView setEditing:YES animated:YES];
    }
}

@end
