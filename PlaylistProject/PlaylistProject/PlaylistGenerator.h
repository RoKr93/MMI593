//
//  PlaylistGenerator.h
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/20/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface PlaylistGenerator : NSObject

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *artistSearchUrl;

- (id)init;
- (NSString *)searchForArtistWithName:(NSString *)artist;
- (NSDictionary *)doHttpRequestWithUrl:(NSString *)urlString;
- (NSMutableArray *)getArtistSongs:(NSString *)artistId;
- (NSMutableArray *)getSongTitles:(NSArray *)songs;
- (NSMutableArray *)getFeaturedArtists:(NSMutableArray *)songTitles;
- (NSMutableArray *)generatePlaylist:(NSString *)artist;

@end
