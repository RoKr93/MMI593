//
//  ViewController.m
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/15/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSMutableArray *generatedPlaylist;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateButtonPressed:(id)sender
{
    //Make a playlist generator object??
    PlaylistGenerator *pg = [[PlaylistGenerator alloc] init];
    [pg searchForArtistWithName:@"drake"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
