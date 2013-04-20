//
//  TPRecentViewController.m
//  TopPlaces
//
//  Created by Kenneth Bambridge on 4/17/13.
//  Copyright (c) 2013 Kenneth Bambridge. All rights reserved.
//

#import "TPListViewController.h"
#import "TPPhotoViewController.h"
#import "FlickrFetcher.h"

@interface TPListViewController ()

@end

@implementation TPListViewController {
    NSDictionary *photoToSend;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
	// Do any additional setup after loading the view, typically from a nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    [self getPhotos];
}

-(void) getPhotos
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photo"];
    cell.textLabel.text = self.photos[indexPath.row][@"title"];
    if ([cell.textLabel.text isEqualToString:@""]){
        cell.textLabel.text = self.photos[indexPath.row][@"description"][@"_content"];
        if ([cell.textLabel.text isEqualToString:@""]) {
            cell.textLabel.text = @"Unknown";
        }
        cell.detailTextLabel.text = @"";
    }
    else {
        cell.detailTextLabel.text = self.photos[indexPath.row][@"description"][@"_content"];
    }
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[FlickrFetcher urlForPhoto:self.photos[indexPath.row] format:FlickrPhotoFormatSquare]]];
    //    cell.detailTextLabel.text = topPlaces[indexPath.row][@"photo_count"];
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.photos) ? self.photos.count : 0;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setPhoto:photoToSend];
}

#pragma mark UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    photoToSend = self.photos[indexPath.row];
    [self performSegueWithIdentifier:@"view" sender:self];
}
@end