//
//  TPRecentViewController.m
//  TopPlaces
//
//  Created by Kenneth Bambridge on 4/18/13.
//  Copyright (c) 2013 Kenneth Bambridge. All rights reserved.
//

#import "TPRecentViewController.h"
#import "FlickrFetcher.h"

@interface TPRecentViewController ()

@end

#define numPhotos 20

@implementation TPRecentViewController

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
    self.navigationItem.title = @"Recent Uploads";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getPhotos
{
    NSMutableArray *photos = [[FlickrFetcher recentGeoreferencedPhotos] mutableCopy];
    NSLog(@"%@",  photos);
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recents = [[defs arrayForKey:@"recents"] mutableCopy ];
    if (!recents) recents = [NSMutableArray new];
    for (NSDictionary *photo in photos) {
        if ([recents containsObject:photo]) {
            continue;
        }
        [recents addObject:photo];
    }
    [recents sortUsingComparator:^(id obj1, id obj2) {
        if ([obj1[@"dateupload"] integerValue] > [obj2[@"dateupload"] integerValue]) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    [[NSUserDefaults standardUserDefaults]setObject:recents forKey:@"recents"];
    self.photos = [recents subarrayWithRange:NSMakeRange(0, 20)];
}

@end
