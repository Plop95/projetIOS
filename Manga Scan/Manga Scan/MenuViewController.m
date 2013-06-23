//
//  ViewController.m
//  Manga Scan
//
//  Created by Mohamed Abdelli on 23/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image=[UIImage imageNamed:@""];
            cell.textLabel.text=@"TOP";
            cell.detailTextLabel.text=@"Mangas les plus consultés";
            break;
        case 1:
            cell.imageView.image=[UIImage imageNamed:@""];
            cell.textLabel.text=@"FAVORIS";
            cell.detailTextLabel.text=@"Vos mangas favoris";
            break;
        case 2:
            cell.imageView.image=[UIImage imageNamed:@""];
            cell.textLabel.text=@"GENRE";
            cell.detailTextLabel.text=@"Faite une recherche par genre";
            break;
        case 3:
            cell.imageView.image=[UIImage imageNamed:@""];
            cell.textLabel.text=@"TOUT";
            cell.detailTextLabel.text=@"Faite une recherche sur tout les mangas";
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle: nil];
    UITableViewController *controller;
    switch (indexPath.row) {
        case 0:
            controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"TopMangaViewController"];
            break;
        case 1:
            controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"MangasFavorisViewController"];
            break;
        case 2:
            controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"GenreViewController"];
            break;
        case 3:
            controller = [mainStoryboard instantiateViewControllerWithIdentifier:@"MangasViewController"];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
