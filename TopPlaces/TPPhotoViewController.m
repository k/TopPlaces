//
//  TPPhotoViewController.m
//  TopPlaces
//
//  Created by Kenneth Bambridge on 4/17/13.
//  Copyright (c) 2013 Kenneth Bambridge. All rights reserved.
//

#import "TPPhotoViewController.h"
#import "FlickrFetcher.h"

@interface TPPhotoViewController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TPPhotoViewController

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
    self.navigationItem.title = self.photo[@"title"];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[FlickrFetcher urlForPhoto:self.photo format:FlickrPhotoFormatLarge]]]];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.bounds.size;
    [self.imageView setNeedsDisplay];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 2.0;
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIScrollViewDelegate

-(UIView *) viewForZoomingInScrollView:(UIScrollView *) scrollView{
    return self.imageView;
}

-(void) scrollViewDidZoom:(UIScrollView *)scrollView
{
}

@end
