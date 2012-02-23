#import "QPScoreDisplay.h"

@implementation QPScoreDisplay
@synthesize time, accuracy, modifierTotal;
@synthesize timeLabel, accuracyLabel, modifierLabel;
@synthesize timeScoreLabel, accuracyScoreLabel, modifierScoreLabel;

- (NSInteger)timeScoreModifier {
    return 3;
}

- (NSInteger)accuracyScoreModifier {
    return 100;
}

- (NSInteger)modifierScoreModifier {
    return 5000;
}
    
- (void)generateLabels {
    self.timeLabel = [CCLabelTTF labelWithString:@"Time" fontName:@"Courier New" fontSize:23];
    self.timeLabel.position = ccp(384,300);
 //   [self.timeLabel setAnchorPoint:ccp(0,0)];

    NSString *timeScoreString = [NSString stringWithFormat:@"%d x %d", self.time, [self timeScoreModifier]];
    self.timeScoreLabel = [CCLabelTTF labelWithString:timeScoreString fontName:@"Courier New" fontSize:23];
    self.timeScoreLabel.position = ccp(384,320);
 //   [self.timeScoreLabel setAnchorPoint:ccp(0,0)];
    
    self.accuracyLabel = [CCLabelTTF labelWithString:@"Accuracy" fontName:@"Courier New" fontSize:23];
    self.accuracyLabel.position = ccp(384,450);
 //   [self.accuracyLabel setAnchorPoint:ccp(0,0)];

    NSString *accuracyScoreString = [NSString stringWithFormat:@"%.0f x %d", self.accuracy, [self accuracyScoreModifier]];
    self.accuracyScoreLabel = [CCLabelTTF labelWithString:accuracyScoreString fontName:@"Courier New" fontSize:23];
    self.accuracyScoreLabel.position = ccp(384,470);
  //  [self.accuracyScoreLabel setAnchorPoint:ccp(0,0)];
    
    self.modifierLabel = [CCLabelTTF labelWithString:@"Modifiers" fontName:@"Courier New" fontSize:23];
    self.modifierLabel.position = ccp(384,600);
   // [self.modifierLabel setAnchorPoint:ccp(0,0)];

    NSString *modifierScoreString = [NSString stringWithFormat:@"%d x %d", self.modifierTotal, [self modifierScoreModifier]];
    self.modifierScoreLabel = [CCLabelTTF labelWithString:modifierScoreString fontName:@"Courier New" fontSize:23];
    self.modifierScoreLabel.position = ccp(384,620);
 //   [self.modifierScoreLabel setAnchorPoint:ccp(0,0)];

}

- (void)populateDefaultLabelText {
    
}

- (void)addLabelsToLayer:(CCLayer *)layer {
    [layer addChild:self.timeLabel];
    [layer addChild:self.timeScoreLabel];
    [layer addChild:self.accuracyLabel];
    [layer addChild:self.accuracyScoreLabel];
    [layer addChild:self.modifierLabel];
    [layer addChild:self.modifierScoreLabel];
}

- (id)initWithTime:(NSInteger)t accuracy:(float)a modifierTotal:(NSInteger)mt layer:(CCLayer *)layer{
    self = [super init];
    if (self) {
        self.time = t;
        self.accuracy = a;
        self.modifierTotal = mt;
        [self generateLabels];
        [self populateDefaultLabelText];
//        [self performSelector:@selector(calculatePoints)
//                   withObject:nil 
//                   afterDelay:1.5];
        [self addLabelsToLayer:layer];
        
    }
    return self;
}

- (void)dealloc {
    [self.timeLabel removeFromParentAndCleanup:YES];
    self.timeLabel = nil;
    [self.accuracyLabel removeFromParentAndCleanup:YES];
    self.accuracyLabel = nil;
    [self.modifierLabel removeFromParentAndCleanup:YES];
    self.modifierLabel = nil;
    
    [self.timeScoreLabel removeFromParentAndCleanup:YES];
    self.timeScoreLabel = nil;
    [self.accuracyScoreLabel removeFromParentAndCleanup:YES];
    self.accuracyScoreLabel = nil;
    [self.modifierScoreLabel removeFromParentAndCleanup:YES];
    self.modifierScoreLabel = nil;
    [super dealloc];
}

@end
