//
//  PlaylistGenerator.h
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/20/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaylistGenerator : NSObject

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *artistSearchUrl;

- (id)init;
- (NSString *)searchForArtistWithName:(NSString *)artist;
- (NSString *)getArtistSongs:(NSString *)artistId;

@end
