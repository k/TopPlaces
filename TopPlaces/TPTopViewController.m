//
//  TPTopViewController.m
//  TopPlaces
//
//  Created by Kenneth Bambridge on 4/9/13.
//  Copyright (c) 2013 Kenneth Bambridge. All rights reserved.
//

#import "TPTopViewController.h"
#import "FlickrFetcher.h" 

@interface TPTopViewController ()

@end

@implementation TPTopViewController {
    NSMutableArray *topPlaces;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self topPlaces];

    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) topPlaces
{
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"_content" ascending:YES];
    NSArray *sorting = @[sort];
    NSArray *places = [[FlickrFetcher topPlaces] sortedArrayUsingDescriptors:sorting];
    topPlaces = [[NSMutableArray alloc]initWithCapacity:20];
    NSLog(@"%@", places);
    for (NSDictionary *place in places) {
        if (topPlaces.count < 20) {
            [topPlaces addObject:place];
            continue;
        }
        [topPlaces sortedArrayUsingComparator:^(id obj1, id obj2) {
            if ([obj1[@"photo_count"] integerValue] > [obj2[@"photo_count"] integerValue]) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }];
        if ([topPlaces[0][@"photo_count"]integerValue] < [place[@"photo_count"] integerValue]){
            topPlaces[0] = place;
        }
    }
    [topPlaces sortUsingDescriptors:sorting];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"top"];
    NSRange city = [topPlaces[indexPath.row][@"_content"] rangeOfString:@","];
    cell.textLabel.text = [topPlaces[indexPath.row][@"_content"] substringToIndex:city.location];
    cell.detailTextLabel.text = [topPlaces[indexPath.row][@"_content"] substringFromIndex:city.location + 2];
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (topPlaces) ? topPlaces.count : 0;
}

@end
