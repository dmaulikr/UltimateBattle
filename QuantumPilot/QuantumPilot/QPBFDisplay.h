//
//  QPBFDisplay.h
//  QuantumPilot
//
//  Created by quantum on 17/07/2014.
//
//

#import "cocos2d.h"

@protocol ScoreDisplayDelegate <NSObject>

- (void)finishedDisplayingWithTotalScore:(int)score;

@end


@interface QPBFDisplay : CCNode {
    CGPoint vertexes[4];
    CGPoint l;
}

@property (strong, nonatomic) CCLabelTTF *timeLabel;
@property (strong, nonatomic) CCLabelTTF *accuracyLabel;
@property (strong, nonatomic) CCLabelTTF *pathingLabel;
@property (strong, nonatomic) CCLabelTTF *scoreLabel;

@property (nonatomic, assign) id <ScoreDisplayDelegate> delegate;

- (void)pulse;
- (float)labelDistance;
- (float)baseLabelDistance;
- (float)selectionLabelDistance;
- (void)drawText;

- (void)drawLabels;

- (CGPoint)center;

- (NSString *)timeText;
- (NSString *)accuracyText;
- (NSString *)pathingText;
- (NSString *)scoreText;

@end

