//
//  PlaylistGenerator.m
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/20/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "PlaylistGenerator.h"

@interface PlaylistGenerator ()

@property DEBUG_LEVEL PG_DEBUG;

@end

@implementation PlaylistGenerator

- (id)init
{
    self = [super init];
    
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        self.artistSearchUrl = @"http://developer.echonest.com/api/v4/artist";
        self.apiKey = @"0N9TCBWKIBVXAP0GY";
        
        self.PG_DEBUG = DEBUG_STANDARD;
    }
    
    return self;
}

#pragma mark - Artist Functions

// Takes the name of an artist- returns the Echo Nest ID of that artist
-(NSString *)searchForArtistWithName:(NSString *)artist
{
    // Replace spaces in the Artist's name with '%20'
    NSString *formattedArtist = [artist stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    // create the GET request string
    NSString *urlString = [NSString stringWithFormat:@"%@/search?api_key=%@&name=%@", self.artistSearchUrl, self.apiKey, formattedArtist];
    
    if (self.PG_DEBUG >= DEBUG_STANDARD)
        NSLog(@"%@", urlString);

    // do the HTTP request
    NSDictionary *result = [self doHttpRequestWithUrl:urlString];
    
    // parse the result, extracting the first artist result and getting its ID
    NSString *artistId = NULL;
    if(result != NULL)
    {
        NSArray *artists = [result objectForKey:@"artists"];
        artistId = [artists[0] objectForKey:@"id"];
        
        if (self.PG_DEBUG >= DEBUG_VERBOSE)
        {
            NSLog(@"Printing Returned Artists\n\n");
            for (int i = 0; i < artists.count; i++)
            {
                NSLog(@"%d: %@\n", i, [artists[i] objectForKey:@"name"]);
            }
        }
    }
    return artistId;
}

// return all songs that contain featured artists
- (NSMutableArray *)getArtistSongsById:(NSString *)artistId andName:(NSString *)artistName
{
    if(artistId == NULL)
        return NULL;
    
    NSArray *songs = NULL;
    NSMutableArray *songsWithFeatured = [[NSMutableArray alloc] init];
    
    if (self.PG_DEBUG >= DEBUG_VERBOSE)
        NSLog(@"Printing All of %@'s Songs with Featured Artists...\n\n", artistName);
        
    for(int i = 0; i <= 300; i += 100)
    {
        // create the GET request string
        NSString *urlString = [NSString stringWithFormat:@"%@/songs?api_key=%@&id=%@&format=json&start=%d&results=100", self.artistSearchUrl, self.apiKey, artistId, i];

        if (self.PG_DEBUG >= DEBUG_STANDARD)
            NSLog(@"%@", urlString);
        
        // do the HTTP request
        NSDictionary *result = [self doHttpRequestWithUrl:urlString];
        
        if(result != NULL)
        {
            songs = [result objectForKey:@"songs"];
            
            // get the songs that contain featured artists
            for(NSObject *song in songs)
            {
                NSString *title = [song valueForKey:@"title"];
                NSString *uuid = [song valueForKey:@"id"];
                NSRange feat = [title rangeOfString:@"feat." options:NSCaseInsensitiveSearch];
                NSRange featuring = [title rangeOfString:@"featuring" options:NSCaseInsensitiveSearch];
                
                // if an artist is featured, add it to the mutable array
                if(feat.length != 0 || featuring.length != 0)
                {
                    Song *newSong = [[Song alloc] initWithTitle:title Artist:artistName andUUID:uuid];
                    [songsWithFeatured addObject:newSong];
                    
                    if (self.PG_DEBUG >= DEBUG_VERBOSE)
                        [newSong print];
                }
            }
        }
    }
    
    return songsWithFeatured;
}

- (NSMutableArray *)getFeaturedArtists:(NSMutableArray *)allSongs
{
    if(allSongs == NULL)
        return NULL;
    
    NSMutableArray *featuredArtists = [[NSMutableArray alloc] init];
    for(Song *aSong in allSongs)
    {
        NSRange featRange = [aSong.title rangeOfString:@"feat." options:NSCaseInsensitiveSearch];
        
        if (featRange.length == 0)
        {
            featRange = [aSong.title rangeOfString:@"featuring" options:NSCaseInsensitiveSearch];
        }
        
        if(featRange.length != 0)
        {
            NSMutableArray *allArtists = [[[aSong.title substringFromIndex:(featRange.location + featRange.length)] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",&"]] mutableCopy];
            
            for (int i = 0; i < allArtists.count; i++)
            {
                NSString *a = allArtists[i];
                
                NSRange symRange = [a rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
                if (symRange.length != 0)
                {
                    a = [a substringToIndex:symRange.location];
                }
                
                [featuredArtists addObject:[a stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            }
        }
    }
    
    return featuredArtists;
}

- (NSMutableArray *)generatePlaylistWithArtist:(NSString *)artist andLength:(int)size
{
    // create the empty playlist array
    NSMutableArray *playlist = [[NSMutableArray alloc] init];
    
    // create a local variable to store the current artist in
    NSString *currentArtist = artist;
    
    for(int i = 0; i < size; i++)
    {
        //Get an Artist's ID
        NSString *artistId = [self searchForArtistWithName:currentArtist];
        
        //Get an array of Songs by the Current Artist
        NSMutableArray *songs = [self getArtistSongsById:artistId andName:currentArtist];
        
        //Trim that array to contain only songs Featuring at least One other Artist
        NSMutableArray *featured = [self getFeaturedArtists:songs];
        
        // right now we're just gonna select a random song/first featured artist to use
        // TODO: possible better way to select next song/featured artist?
        int randIndex = arc4random() % songs.count;

        //Make sure the featured artist isn't the current artist
        while([currentArtist isEqualToString:featured[randIndex]])
        {
            randIndex = arc4random() % songs.count;
        }
        
        [playlist addObject:songs[randIndex]];
        currentArtist = featured[randIndex];
    }
    
    return playlist;
}

#pragma mark - Helper Functions

- (NSDictionary *)doHttpRequestWithUrl:(NSString *)urlString
{
    // create an NSURL from the string
    NSURL *url = [NSURL URLWithString:urlString];
    
    // create the request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // create variables to hold response and/or error
    NSURLResponse *response;
    NSError *error;
    
    // send our request away
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // handle possible error (poorly)
    // TODO: more robust error handling?
    if(error != nil)
    {
        NSLog(@"%@", error);
        return NULL;
    }
    
    // parse the JSON
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    if (error != nil)
    {
        NSLog(@"Error parsing JSON.");
        return NULL;
    }
    
    return [jsonArray objectForKey:@"response"];
}

@end
