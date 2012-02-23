#import "cocos2d.h"

@interface QPScoreDisplay : CCNode

@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) float accuracy;
@property (nonatomic, assign) NSInteger modifierTotal;
@property (nonatomic, retain) CCLabelTTF *timeLabel;
@property (nonatomic, retain) CCLabelTTF *accuracyLabel;
@property (nonatomic, retain) CCLabelTTF *modifierLabel;
@property (nonatomic, retain) CCLabelTTF *timeScoreLabel;
@property (nonatomic, retain) CCLabelTTF *accuracyScoreLabel;
@property (nonatomic, retain) CCLabelTTF *modifierScoreLabel;

- (id)initWithTime:(NSInteger)t accuracy:(float)a modifierTotal:(NSInteger)mt layer:(CCLayer *)layer;

@end
