//
//  Song.h
//  PlaylistProject
//
//  Created by Evan Shenkman on 1/20/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property NSString *title;
@property NSString *artist;
@property NSMutableArray *featuredArtists;
@property NSString *UUID;

- (id)initWithTitle:(NSString *)title Artist:(NSString *)artist andUUID:(NSString *)uuid;
- (NSMutableArray *)getFeaturedArtists;

@end
