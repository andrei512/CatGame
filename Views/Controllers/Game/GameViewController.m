//
//  GameViewController.m
//  Views
//
//  Created by Andrei Puni on 30/11/13.
//  Copyright (c) 2013 Andrei Puni. All rights reserved.
//

#import "GameViewController.h"
#import "CatView.h"

const NSString *kDescription = @"kDescription";
const NSString *kSolution = @"kSolution";

#define MAX_CATS 5

#define FPS 60
#define TIME_PER_FRAME 1.0f/((double)FPS)

#define LOW_CHANCE ((rand() % 5 * FPS) == 0)
#define FIFTY_FIFTY (rand() % 2 == 0)


@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil
                               bundle:nibBundleOrNil]) {
        self.cats = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupDefaults];
    
    [self generateNewPuzzle];
    
    [self addCatWithNumber:2];
    [self addCatWithNumber:3];

    [self startTimer];
}

#pragma mark - Defaults

- (void)setupDefaults {
    self.timeLeft = 30.0;
    self.score = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(catWasTapped:)
                                                 name:kCatWasTapped
                                               object:nil];
    
    [self updateTimeLabel];
    [self updateScoreLabel];
}

#pragma mark - UI

- (void)updateTimeLabel {
    int time = (int)self.timeLeft;
    int minutes = time / 60;
    int seconds = time % 60;
    
    self.timeLabel.text =
        [NSString stringWithFormat:@"Time: %02d:%02d", minutes, seconds];
}

- (void)updateScoreLabel {
    self.scoreLabel.text =
        [NSString stringWithFormat:@"Score : %04d", self.score];
}

#pragma mark - Time

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_PER_FRAME
                                                  target:self
                                                selector:@selector(tick:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)tick:(NSTimer *)timer {
    self.timeLeft -= TIME_PER_FRAME;

    if (self.timeLeft > 0) {
        // normal game loop
        [self updateTimeLabel];
        
        [self handleCats];
    } else {
        [self stopGame];
    }
}

#pragma mark - Logic

- (void)stopGame {
    [self.timer invalidate];
    
    NSString *message =
        [NSString stringWithFormat:@"You scored %d point%@",
                                    self.score,
                                    self.score != 1 ? @"s" : @""];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [alertView show];
    
    self.stopGameAlertView = alertView;
}

#pragma mark - UIAlertViewDelegatew

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == self.stopGameAlertView) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Cats

- (void)addCatWithNumber:(int)number {
    CatView *catView = [CatView newCatWithNumber:number];
    
    [self.view addSubview:catView];
    [self.view sendSubviewToBack:catView];
    
    [self.cats addObject:catView];
}

- (void)removeCat:(CatView *)catView {
    [catView removeFromSuperview];
    [self.cats removeObject:catView];
}

- (void)catWasTapped:(NSNotification *)notification {
    CatView *catView = (CatView *)[notification object];
 
    int currentPuzzleSolution = [(NSNumber *)self.puzzle[kSolution] intValue];
    if (catView.number == currentPuzzleSolution) {
        self.score += 1;
        [self updateScoreLabel];
        
        // play good sound
        
        [self generateNewPuzzle];
    } else {
        // play bad sound
        self.timeLeft -= 1;
    }
    
    [self removeCat:catView];
}

- (void)handleCats {
    NSMutableArray *catsToRemove = [NSMutableArray array];

    BOOL currentPuzzleHasSolution = NO;
    int currentPuzzleSolution =
        [(NSNumber *)self.puzzle[kSolution] intValue];
    
    for (CatView *catView in self.cats) {
        // move them
        CGRect catFrame = catView.frame;
        catFrame.origin.y += catView.speed;
        catView.frame = catFrame;
        // remember to remove them
        if (CGRectIntersectsRect(catFrame, self.view.bounds) == NO) {
            [catsToRemove addObject:catView];
        }
        // check if puzzle has solution
        if (catView.number == currentPuzzleSolution) {
            currentPuzzleHasSolution = YES;
        }
    }
    
    // remove them
    for (CatView *catView in catsToRemove) {
        [self removeCat:catView];
    }
    
    if (currentPuzzleHasSolution == NO &&
        LOW_CHANCE &&
        self.cats.count < MAX_CATS) {
        if (FIFTY_FIFTY) {
            [self addCatWithNumber:currentPuzzleSolution];
        } else {
            [self addCatWithNumber:rand() % 10 + rand() % 10];
        }
    }
}

#pragma mark - Puzzle

- (void)generateNewPuzzle {
    self.puzzle = [GameViewController randomPuzzle];
    
    self.puzzleLabel.text = self.puzzle[kDescription];
}

+ (NSDictionary *)randomPuzzle {
    int a = rand() % 10, b = rand() % 10;
    
    NSString *description = [NSString stringWithFormat:@"%d + %d = ?", a, b];
    NSNumber *solution = @(a + b);
    
    return @{
             kDescription : description,
             kSolution : solution
    };
}

@end
