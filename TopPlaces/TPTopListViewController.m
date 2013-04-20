//
//  TPTopListViewController.m
//  TopPlaces
//
//  Created by Kenneth Bambridge on 4/18/13.
//  Copyright (c) 2013 Kenneth Bambridge. All rights reserved.
//

#import "TPTopListViewController.h"
#import "TPPhotoViewController.h"
#import "FlickrFetcher.h"

@interface TPTopListViewController ()

@end

@implementation TPTopListViewController {
    NSDictionary *photoToSend;
}

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
    [super viewDidLoad];
    self.navigationItem.title = self.place[@"_content"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getPhotos
{
    self.photos = [FlickrFetcher photosInPlace:self.place maxResults:50];
}





@end
