//
//  GameViewController.h
//  Views
//
//  Created by Andrei Puni on 30/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const NSString *kDescription;
FOUNDATION_EXPORT const NSString *kSolution;

@interface GameViewController : UIViewController<UIAlertViewDelegate>

#pragma mark - Logic

@property (nonatomic, strong) NSMutableArray *cats;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDictionary *puzzle;

@property NSTimeInterval timeLeft;
@property int score;

#pragma mark - UI

@property (nonatomic, weak) IBOutlet UILabel *puzzleLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

@property (nonatomic, weak) UIAlertView *stopGameAlertView;


+ (NSDictionary *)randomPuzzle;

- (void)stopGame;



// Version 0.2 ;)
//- (void)pauseGame;
//- (void)resumeGame;

@end
