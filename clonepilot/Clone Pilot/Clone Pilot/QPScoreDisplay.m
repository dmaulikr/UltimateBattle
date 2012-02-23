#import "QPScoreDisplay.h"

@implementation QPScoreDisplay
@synthesize time, accuracy, modifierTotal;
@synthesize timeLabel, accuracyLabel, modifierLabel;

- (void)generateLabels {
    
}

- (void)populateDefaultLabelText {
    
}

- (id)initWithTime:(NSInteger)t accuracy:(float)a modifierTotal:(NSInteger)mt {
    self = [super init];
    if (self) {
        self.time = t;
        self.accuracy = a;
        self.modifierTotal = mt;
        [self generateLabels];
        [self populateDefaultLabelText];
        [self performSelector:@selector(calculatePoints)
                   withObject:nil 
                   afterDelay:1.5];
        
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
    [super dealloc];
}

@end
