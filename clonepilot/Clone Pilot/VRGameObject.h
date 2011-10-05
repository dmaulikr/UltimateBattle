#import <Foundation/Foundation.h>


@protocol VRGameObject <NSObject>

@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) CGPoint t;

@end