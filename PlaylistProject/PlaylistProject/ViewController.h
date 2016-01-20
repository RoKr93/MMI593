//
//  ViewController.h
//  PlaylistProject
//
//  Created by Roshan Krishnan on 1/15/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"

@interface ViewController : UIViewController

@property IBOutlet UITextField *artistInput;
@property IBOutlet UIButton *generateButton;
@property IBOutlet UITableView *playlistTable;

@end
