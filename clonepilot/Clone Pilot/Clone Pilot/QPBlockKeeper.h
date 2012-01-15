//QPBlockKeeper.h

#import <Foundation/Foundation.h>

typedef void (^BlockKeeperBlock)(NSDictionary *d);

@interface QPBlockKeeper : NSObject

@property (readwrite, copy) BlockKeeperBlock paramBlock;
@property (nonatomic, retain) NSDictionary *executionParams;

- (void)executeWithParameters:(NSDictionary *)d;
- (void)executeWithDefaultParameters;

@end
