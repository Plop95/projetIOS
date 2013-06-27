//
//  ImagesViewController.m
//  Manga Scan
//
//  Created by Mohamed Abdelli on 23/06/13.
//  Copyright (c) 2013 motCorporation. All rights reserved.
//

#import "ImagesViewController.h"

@implementation ImagesViewController

@synthesize chapitreID;
@synthesize numChap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = [NSString stringWithFormat:@"Chapitre %@",numChap];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
    [_scrollView addGestureRecognizer:tap];
    
    _scrollView.maximumZoomScale = 4.0;
    _scrollView.minimumZoomScale = 1.0;
    
    imagesDictionary = [[NSMutableDictionary alloc] init];
        
    [self wsAllImages];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)wsAllImages{
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityView setFrame:CGRectMake(self.view.frame.size.width/2-activityView.frame.size.width/2, self.view.frame.size.height/2-activityView.frame.size.height/2, activityView.frame.size.width, activityView.frame.size.height)];
    [activityView startAnimating];
    [self.scrollView addSubview:activityView];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *_urlString = [NSString stringWithFormat:@"%@%@",wsGetAllImages,chapitreID];
    NSURL *_url = [NSURL URLWithString:_urlString];
    
    NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:_url];
    
    NSDictionary *_headers = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"accept", nil];
    
    [_request setAllHTTPHeaderFields:_headers];
    
    [NSURLConnection sendAsynchronousRequest:_request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
                               
                               NSError *_errorJson = nil;
                               NSDictionary *_reponseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&_errorJson];
                               
                               if (_errorJson != nil) {
                                   NSLog(@"Error %@", [_errorJson localizedDescription]);
                               } else {
                                   //Do something with returned array
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       
                                       [activityView stopAnimating];
                                       [activityView removeFromSuperview];
                                       
                                       NSArray *interArray = [[NSArray alloc] initWithArray:[_reponseDic valueForKeyPath:@"images"]];
                                       
                                        NSMutableArray *interImgArray = [[NSMutableArray alloc] init];
                                       for (NSArray *array in interArray) {
                                           NSDictionary *entry = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                  [array objectAtIndex:0],@"page",
                                                                  [array objectAtIndex:1],
                                                                  @"url",
                                                                  nil];
                                           
                                           [interImgArray addObject:entry];
                                       }
                                       
                                       imgArray = [interImgArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"page" ascending:YES]]];
                                       
                                       NSString *url = [NSString stringWithFormat:@"%@%@",imgURL,[[imgArray objectAtIndex:0] valueForKeyPath:@"url"]];
                                       currentPage=0;
                                       [self afficheAsyncImageFromURL:url];
                                       
                                   });
                               }
                               
                           }];
}

-(void)afficheAsyncImageFromURL:(NSString *)url{
    if ([imagesDictionary objectForKey:url])
        
    {
        
        // 3
        _imgView.image = [imagesDictionary objectForKey:url];
        _scrollView.contentSize = CGSizeMake(_imgView.frame.size.width, _imgView.frame.size.height);

    }
    else
    {
        // 4
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView setFrame:CGRectMake(self.view.frame.size.width/2-activityView.frame.size.width/2, self.view.frame.size.height/2-activityView.frame.size.height/2, activityView.frame.size.width, activityView.frame.size.height)];
        [activityView startAnimating];
        [self.scrollView addSubview:activityView];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *imageURL = [NSURL URLWithString:url];
                           
                           // 5
                           __block NSData *imageData;
                           
                           // 6
                           
                           dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                                         ^{
                                             imageData = [NSData dataWithContentsOfURL:imageURL];
                                             
                                             // 7
                                             [imagesDictionary setObject:[UIImage imageWithData:imageData] forKey:url];
                                             
                                             // 8
                                             dispatch_sync(dispatch_get_main_queue(), ^{
                                                 _imgView.image = [imagesDictionary objectForKey:url];
                                                 _scrollView.contentSize = CGSizeMake(_imgView.frame.size.width, _imgView.frame.size.height);
                                                 [activityView stopAnimating];
                                                 [activityView removeFromSuperview];
                                                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                             });
                                         });
                       });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f %f",scrollView.contentOffset.x,_imgView.frame.size.width);
    
    if (currentPage<imgArray.count-1 && currentPage>0) {
        if ((scrollView.contentOffset.x+self.view.frame.size.width)>_imgView.frame.size.width+30) {
            [UIView transitionFromView:self.view toView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished){
                currentPage++;
                
                NSString *url = [NSString stringWithFormat:@"%@%@",imgURL,[[imgArray objectAtIndex:currentPage] valueForKeyPath:@"url"]];
                [self afficheAsyncImageFromURL:url];
            }];
        }
        
        else if (scrollView.contentOffset.x<-30) {
            [UIView transitionFromView:self.view toView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCurlDown completion:^(BOOL finished){
                currentPage--;
                
                NSString *url = [NSString stringWithFormat:@"%@%@",imgURL,[[imgArray objectAtIndex:currentPage] valueForKeyPath:@"url"]];
                [self afficheAsyncImageFromURL:url];
            }];
        }
    }
    
    else if (currentPage==imgArray.count-1) {
        if (scrollView.contentOffset.x<-30) {
            [UIView transitionFromView:self.view toView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCurlDown completion:^(BOOL finished){
                currentPage--;
                
                NSString *url = [NSString stringWithFormat:@"%@%@",imgURL,[[imgArray objectAtIndex:currentPage] valueForKeyPath:@"url"]];
                [self afficheAsyncImageFromURL:url];
            }];
        }
    }
    
    else if (currentPage==0) {
        if ((scrollView.contentOffset.x+self.view.frame.size.width)>_imgView.frame.size.width+30) {
            
            [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                currentPage++;
                
                NSString *url = [NSString stringWithFormat:@"%@%@",imgURL,[[imgArray objectAtIndex:currentPage] valueForKeyPath:@"url"]];
                [self afficheAsyncImageFromURL:url];
            }completion:nil];
        }
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imgView;
}

-(void)tapScrollView:(UITapGestureRecognizer *)gesture{
    if (_toolbar.alpha==0.0) {
        [UIView animateWithDuration:0.5 animations:^{
            [_toolbar setAlpha:1.0];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [_toolbar setAlpha:0.0];
        }];
    }
}

@end
