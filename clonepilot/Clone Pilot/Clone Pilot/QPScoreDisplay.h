#import "cocos2d.h"

@interface QPScoreDisplay : CCNode

@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) float accuracy;
@property (nonatomic, assign) NSInteger modifierTotal;
@property (nonatomic, retain) CCLabelTTF *timeLabel;
@property (nonatomic, retain) CCLabelTTF *accuracyLabel;
@property (nonatomic, retain) CCLabelTTF *modifierLabel;

- (id)initWithTime:(NSInteger)t accuracy:(float)a modifierTotal:(NSInteger)mt;

@end
