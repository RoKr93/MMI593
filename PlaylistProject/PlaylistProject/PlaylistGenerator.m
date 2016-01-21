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
        NSString *artistName = @"drake";
        NSString *artistSearchUrl = @"http://developer.echonest.com/api/v4/artist/search";
        NSDictionary *params = @{@"api_key": @"0N9TCBWKIBVXAP0GY", @"name": artistName};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

@end
