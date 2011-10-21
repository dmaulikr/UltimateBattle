#import <Foundation/Foundation.h>
#import "BulletHellBattlefield.h"
#import "ClonePlayer.h"
#import "ClonePilot.h"

@interface ClonePilotBattlefield : BulletHellBattlefield <BulletDelegate> {
    
}

@property (nonatomic, retain) ClonePlayer *player;
@property (nonatomic, retain) NSMutableArray *clones;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) float shotsFired;
@property (nonatomic, assign) float hits;

- (void)startup;
- (NSInteger)livingClones;

- (ClonePilot *)latestClone;

- (void)advanceLevel;

@end
