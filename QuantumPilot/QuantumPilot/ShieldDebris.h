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
}

@property (strong, nonatomic) QuantumPilot *pilot;

@property (strong, nonatomic) NSString *weapon;

@end
