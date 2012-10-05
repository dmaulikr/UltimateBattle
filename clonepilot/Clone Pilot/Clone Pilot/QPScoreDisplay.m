#import "QPScoreDisplay.h"

@implementation QPScoreDisplay
@synthesize time, accuracy, modifierTotal;
@synthesize timeLabel, accuracyLabel, modifierLabel;
@synthesize timeScoreLabel, accuracyScoreLabel, modifierScoreLabel;
@synthesize continueLabel = _continueLabel;

- (NSInteger)timeScoreModifier {
    return 3;
}

- (NSInteger)accuracyScoreModifier {
    return 100;
}

- (NSInteger)modifierScoreModifier {
    return 5000;
}

- (void)generateLabelsWithTimeBonus:(NSInteger)timeBonus accuracyBonus:(NSInteger)accuracyBonus {
    self.timeLabel = [CCLabelTTF labelWithString:@"Time" fontName:@"Courier New" fontSize:23];
    self.timeLabel.position = ccp(384,300);

    NSString *timeScoreString = [NSString stringWithFormat:@"+ %d", timeBonus];
    self.timeScoreLabel = [CCLabelTTF labelWithString:timeScoreString fontName:@"Courier New" fontSize:23];
    self.timeScoreLabel.position = ccp(384,320);
    
    self.accuracyLabel = [CCLabelTTF labelWithString:@"Accuracy" fontName:@"Courier New" fontSize:23];
    self.accuracyLabel.position = ccp(384,450);

    NSString *accuracyScoreString = [NSString stringWithFormat:@"+ %d", accuracyBonus];
    self.accuracyScoreLabel = [CCLabelTTF labelWithString:accuracyScoreString fontName:@"Courier New" fontSize:23];
    self.accuracyScoreLabel.position = ccp(384,470);
    
    self.modifierLabel = [CCLabelTTF labelWithString:@"Modifiers" fontName:@"Courier New" fontSize:23];
    self.modifierLabel.position = ccp(384,600);

    NSString *modifierScoreString = [NSString stringWithFormat:@"%d x %d", self.modifierTotal, [self modifierScoreModifier]];
    self.modifierScoreLabel = [CCLabelTTF labelWithString:modifierScoreString fontName:@"Courier New" fontSize:23];
    self.modifierScoreLabel.position = ccp(384,620);


}

- (void)showContinueLabel {
    self.continueLabel = [CCLabelTTF labelWithString:@"Tap to Continue"
                                                fontName:@"Courier New"
                                                fontSize:23];
    self.continueLabel.position = ccp(384, 760);
    [self addChild:self.continueLabel];
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

- (id)initWithTimeBonus:(NSInteger)timeBonus accuracyBonus:(NSInteger)accuracyBonus layer:(CCLayer *)layer {
    self = [super init];
    if (self) {
        [self generateLabelsWithTimeBonus:timeBonus accuracyBonus:accuracyBonus];
        [self addLabelsToLayer:layer];
        [layer addChild:self];
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

    [self.continueLabel removeFromParentAndCleanup:YES];
    self.continueLabel = nil;
    [super dealloc];
}

@end
