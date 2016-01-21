//
//  Song.m
//  PlaylistProject
//
//  Created by Evan Shenkman on 1/20/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import "Song.h"

@implementation Song

- (id)initWithTitle:(NSString *)title Artist:(NSString *)artist andUUID:(NSString *)uuid
{
    self = [super init];
    if (self)
    {
        // superclass successfully initialized, further
        // initialization happens here ...
        self.title = title;
        self.artist = artist;
        self.UUID = uuid;
    }
    return self;
}

@end
