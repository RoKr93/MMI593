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
        self.featuredArtists = [self getFeaturedArtists];
    }
    return self;
}

- (NSMutableArray *)getFeaturedArtists {
    NSMutableArray *featuredArtists = [[NSMutableArray alloc] init];
    
    NSRange featRange = [self.title rangeOfString:@"feat." options:NSCaseInsensitiveSearch];
    
    if (featRange.length == 0)
    {
        featRange = [self.title rangeOfString:@"featuring" options:NSCaseInsensitiveSearch];
    }
    
    if(featRange.length != 0)
    {
        NSMutableArray *allArtists = [[[self.title substringFromIndex:(featRange.location + featRange.length)] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",&"]] mutableCopy];
        
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
    
    return featuredArtists;
}

@end
