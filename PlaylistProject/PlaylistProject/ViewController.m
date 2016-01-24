//
//  ViewController.m
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/15/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "ViewController.h"

#define pCellID @"playlistCellID"

@interface ViewController ()

@property PlaylistGenerator *generator;
@property NSMutableArray *generatedPlaylist;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.generator = [[PlaylistGenerator alloc] init];
    [self.playlistTable setDelegate:self];
    [self.playlistTable setDataSource:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)generateButtonPressed:(id)sender
{
    //Make a playlist generator object??
    NSString *artist = self.artistInput.text;
    
    self.generatedPlaylist = [self.generator generatePlaylistWithArtist:artist andLength:5];
    for(Song *s in self.generatedPlaylist)
    {
        [s print];
    }

    [self.playlistTable reloadData];
}

#pragma mark - Table View Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (self.generatedPlaylist != nil)
    {
        rows = self.generatedPlaylist.count;
    }
    
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"~Generated Playlist~";
    
//    if (self.generatedPlaylist != nil)
//    {
//        title = [NSString stringWithFormat:@"Playlist Generated Starting With: %@", self.artistInput.text];
//    }
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pCellID];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pCellID];
    }
    
    Song *thisSong = [self.generatedPlaylist objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ by %@", thisSong.title, thisSong.artist]];
    
    return cell;
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
