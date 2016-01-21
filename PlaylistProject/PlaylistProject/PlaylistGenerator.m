//
//  PlaylistGenerator.m
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/20/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "PlaylistGenerator.h"

@implementation PlaylistGenerator

- (id)init {
    self = [super init];
    if (self){
        // superclass successfully initialized, further
        // initialization happens here ...
        self.artistSearchUrl = @"http://developer.echonest.com/api/v4/artist";
        self.apiKey = @"0N9TCBWKIBVXAP0GY";
    }
    return self;
}

- (NSDictionary *)doHttpRequestWithUrl:(NSString *)urlString {
    // create an NSURL from the string
    NSURL *url = [NSURL URLWithString:urlString];
    
    // create the request
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // create variables to hold response and/or error
    NSURLResponse *response;
    NSError *error;
    
    // send our request away
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // handle possible error (poorly)
    // TODO: more robust error handling?
    if(error != nil){
        NSLog(@"Error with searchForArtistWithName GET request.");
        return NULL;
    }
    
    // parse the JSON
    NSError *jError = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jError];
    
    if (jError != nil) {
        NSLog(@"Error parsing JSON.");
        return NULL;
    }

    return jsonArray;
}


// Takes the name of an artist- returns the Echo Nest ID of that artist
-(NSString *)searchForArtistWithName:(NSString *)artist {
    // create the GET request string
    NSString *urlString = [NSString stringWithFormat:@"%@/search?api_key=%@&name=%@", self.artistSearchUrl, self.apiKey, artist];
    NSLog(@"%@", urlString);

    // do the HTTP request
    NSDictionary *result = [self doHttpRequestWithUrl:urlString];
    
    // parse the result, extracting the first artist result and getting its ID
    NSString *artistId = NULL;
    if(result != NULL){
        NSArray *artists = [[result objectForKey:@"response"] objectForKey:@"artists"];
        artistId = [artists[0] objectForKey:@"id"];
        //NSLog(@"%@", artistId);
        //NSArray *songs = [self getArtistSongs:artistId];
        //[self getSongTitles:songs];
    }
    return artistId;
}

- (NSMutableArray *)getArtistSongs:(NSString *)artistId {
    if(artistId == NULL)
        return NULL;
    // create the GET request string
    NSString *urlString = [NSString stringWithFormat:@"%@/songs?api_key=%@&id=%@&format=json&start=0&results=100", self.artistSearchUrl, self.apiKey, artistId];
    NSLog(@"%@", urlString);
    
    // do the HTTP request
    // cast it to a string; it'll be simpler just to search through this
    NSArray *songs = NULL;
    NSDictionary *result = [self doHttpRequestWithUrl:urlString];
    if(result != NULL){
        songs = [[result objectForKey:@"response"] objectForKey:@"songs"];
        //NSLog(@"%@", songs);
    }
    return [self getSongTitles:songs];
}

// helper function that returns an array of song titles in string format
- (NSMutableArray *)getSongTitles:(NSArray *)songs {
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    if(songs == NULL)
        return NULL;
    for(NSObject *obj in songs){
        NSString *title = [obj valueForKey:@"title"];
        [titles addObject:[NSString stringWithFormat:@"%@", title]];
    }
    return titles;
}

@end
