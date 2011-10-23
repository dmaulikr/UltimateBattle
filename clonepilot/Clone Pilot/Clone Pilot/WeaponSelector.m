//
//  WeaponSelector.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/22/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "WeaponSelector.h"

@implementation WeaponSelector

@synthesize weaponChoices;
@synthesize singleLaser;
@synthesize splitLaser;
@synthesize triLaser;
@synthesize quadLaser;
@synthesize chosenWeapons;
@synthesize delegate;

- (id)initWithBattlefield:(id)field {
    self = [super init];
    if (self) {
        self.delegate = field;
        self.singleLaser = [[[SingleLaser alloc] init] autorelease];
        self.splitLaser = [[[SplitLaser alloc] init] autorelease];
        self.triLaser = [[[TriLaser alloc] init] autorelease];
        self.quadLaser = [[[QuadLaser alloc] init] autorelease];
        self.chosenWeapons = [NSMutableArray array];
    }
    
    return self;
}

- (void)startup {
    self.chosenWeapons = [NSMutableArray arrayWithObjects:self.singleLaser, self.quadLaser, nil];
}

- (void)openWeaponOptions {
    if ([self.delegate level] == 0) {
        self.weaponChoices = [NSArray arrayWithObjects:self.splitLaser, self.triLaser, nil];
    }
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    Weapon *chosenWeapon = [self.weaponChoices objectAtIndex:choiceIndex];
    [self.chosenWeapons addObject:chosenWeapon];
    [self.delegate playerChoseWeapon:chosenWeapon];
}

- (void)dealloc {
    [weaponChoices release];
    [singleLaser release];
    [splitLaser release];
    [triLaser release];
    [quadLaser release];
    [chosenWeapons release];
    self.delegate = nil;
    [super dealloc];
}

@end