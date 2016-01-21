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

-(void)searchForArtistWithName:(NSString *)artist {
    // create the GET request string
    NSString *urlString = [NSString stringWithFormat:self.artistSearchUrl, @"?api_key=", self.apiKey, @"?name=", artist];
    
    // create an NSURL from the string
    NSURL *reqUrl = [NSURL URLWithString:urlString];
    
    // create the request
    NSURLRequest
    /*AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:self.artistSearchUrl
      parameters:artistSearchParams
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSArray *responseArtists = responseObject;
             for(int i = 0; i < responseArtists.count; i++){
                 NSLog(@"%@\n", responseArtists[i]);
             }
         }failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@", error);
         }
     ];*/
}

@end
