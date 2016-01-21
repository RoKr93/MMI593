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
        self.artistSearchUrl = @"http://developer.echonest.com/api/v4/artist/search";
        self.apiKey = @"0N9TCBWKIBVXAP0GY";
    }
    return self;
}


// Takes the name of an artist- returns the Echo Nest ID of that artist
-(NSString *)searchForArtistWithName:(NSString *)artist {
    // create the GET request string
    NSString *urlString = [NSString stringWithFormat:@"%@?api_key=%@&name=%@", self.artistSearchUrl, self.apiKey, artist];
    NSLog(@"%@", urlString);
    
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
        NSLog(@"Error with GET request.");
        return NULL;
    }
    
    // parse the JSON
    NSError *jError = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jError];
    
    // string to store the ID of the top artist
    NSString *artistId = NULL;
    
    // TODO: again, maybe be less terrible about handling this error
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
        return NULL;
    }
    else {
        NSArray *artists = [[jsonArray objectForKey:@"response"] objectForKey:@"artists"];
        artistId = [artists[0] objectForKey:@"id"];
        //NSLog(@"Array: %@", artistId);
    }
    
    return artistId;
}

@end
