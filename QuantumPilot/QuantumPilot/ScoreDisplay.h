//
//  ScoreDisplay.h
//  QuantumPilot
//
//  Created by quantum on 04/07/2014.
//
//

#import "cocos2d.h"

enum displaystate {
    displayZooming = 0,
    displayCalculating,
    displayResting
};

@protocol ScoreDisplayDelegate <NSObject>

- (void)finishedDisplayingWithTotalScore:(int)score;

@end

@interface ScoreDisplay : CCNode {
    int iteration;
    CGPoint vertexes[4];
    CGPoint l;
    
    int state;
    
    int time;
    int accuracy;
    int pathing;
    int score;
}

@property (strong, nonatomic) CCLabelTTF *timeLabel;
@property (strong, nonatomic) CCLabelTTF *accuracyLabel;
@property (strong, nonatomic) CCLabelTTF *pathingLabel;
@property (strong, nonatomic) CCLabelTTF *scoreLabel;

@property (nonatomic, assign) id <ScoreDisplayDelegate> delegate;

- (int)iteration;

- (void)pulse;

- (id)initWithTimeScore:(int)t accuracyScore:(int)a pathingScore:(int)p currentScore:(int)s;

@end
