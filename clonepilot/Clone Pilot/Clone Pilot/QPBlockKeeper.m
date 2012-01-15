//  QPBlockKeeper.m

#import "QPBlockKeeper.h"

@implementation QPBlockKeeper
@synthesize paramBlock;
@synthesize executionParams;

- (void)dealloc {
    [paramBlock release];
    [executionParams release];
    [super dealloc];
}

- (void)executeWithParameters:(NSDictionary *)d {
    self.paramBlock(d);
}

- (void)executeWithDefaultParameters {
    [self executeWithParameters:self.executionParams];
}
 
@end
