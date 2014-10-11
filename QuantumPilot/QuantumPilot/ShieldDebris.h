//
//  ShieldDebris.h
//  QuantumPilot
//
//  Created by quantum on 06/09/2014.
//
//

#import "Debris.h"
#import "QuantumPilot.h"

@interface ShieldDebris : Debris {
    int iterations;
    int _edges;
}

@property (nonatomic, assign) QuantumPilot *pilot;

@property (strong, nonatomic) NSString *weapon;

@end
