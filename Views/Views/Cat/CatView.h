//
//  CatView.h
//  Views
//
//  Created by Andrei Puni on 30/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCatWasTapped @"kCatWasTapped"

@interface CatView : UIView

@property int number;
@property double speed;
@property (nonatomic, weak) IBOutlet UILabel *numberLabel;

+ (instancetype)newCatWithNumber:(int)number;

- (IBAction)catWasTapped:(UIGestureRecognizer *)gestureRecongnizer;

@end
