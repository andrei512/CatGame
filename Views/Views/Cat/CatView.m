//
//  CatView.m
//  Views
//
//  Created by Andrei Puni on 30/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "CatView.h"


@implementation CatView


+ (instancetype)newCatWithNumber:(int)number {
    static UINib *nib = nil;
    if (nib == nil) {
        nib = [UINib nibWithNibName:@"CatView" bundle:nil];
    }
    
    CatView *catView = [nib instantiateWithOwner:nil options:nil][0];
    
    CGRect catFrame = catView.frame;
    
    // give the cat a random position
    catFrame.origin = CGPointMake(rand() % (320 - (int)catFrame.size.width),
                                  -catFrame.size.height);
    
    catView.frame = catFrame;
    catView.speed = 0.5 * (0.5 + (10.0 / (double)(rand() % 10 + 1)));

    
    catView.numberLabel.text = [NSString stringWithFormat:@"%d", number];
    catView.number = number;
    
    return catView;
}

- (IBAction)catWasTapped:(UIGestureRecognizer *)gestureRecongnizer {
    [[NSNotificationCenter defaultCenter] postNotificationName:kCatWasTapped
                                                        object:self
                                                      userInfo:nil];
}

@end
