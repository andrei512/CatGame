//
//  MainViewController.m
//  Views
//
//  Created by Andrei Puni on 30/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
}

- (IBAction)didTapNewGame:(id)sende {
    GameViewController *gameViewController =
        [[GameViewController alloc] initWithNibName:@"GameViewController"
                                             bundle:nil];
    
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (IBAction)didTapTopScores:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    
}


- (IBAction)didTapOptions:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    
}





@end
