//
//  WeaponSelector.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/22/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "WeaponSelector.h"
#import "QPWeaponOptionLayer.h"

@implementation WeaponSelector

@synthesize weaponChoices;
@synthesize singleLaser;
@synthesize splitLaser;
@synthesize triLaser;
@synthesize quadLaser;
@synthesize sideLaser;
@synthesize chosenWeapons;
@synthesize delegate;
@synthesize wideTriLaser;
@synthesize optionLayers;

- (id)initWithBattlefield:(id)field {
    self = [super init];
    if (self) {
        self.delegate = field;
        self.singleLaser    = [[[SingleLaser alloc] init] autorelease];
        self.splitLaser     = [[[SplitLaser alloc] init] autorelease];
        self.triLaser       = [[[TriLaser alloc] init] autorelease];
        self.quadLaser      = [[[QuadLaser alloc] init] autorelease];
        self.sideLaser      = [[[SideLaser alloc] init] autorelease];
        self.wideTriLaser   = [[[WideTriLaser alloc] init] autorelease];
        self.chosenWeapons  = [NSMutableArray array];
        self.optionLayers   = [NSMutableArray array];
    }
    
    return self;
}

- (void)restart {
    [self startup];
    self.weaponChoices = nil;
}

- (void)startup {
    self.chosenWeapons = [NSMutableArray arrayWithObjects:self.singleLaser, self.quadLaser, nil];
}

- (void)displayOptionLayersForWeaponChoices {    
    [self.optionLayers removeAllObjects];
    
    for (Weapon *w in self.weaponChoices) {
        QPWeaponOptionLayer *l = [[QPWeaponOptionLayer alloc] initWithWeapon:w];
        [self.optionLayers addObject:l];
        [l release];
    }
}

- (void)addWeaponOptionLayersToLayer:(CCLayer *)layer {
    NSInteger possibleWeapons = [self.weaponChoices count] >= 2 ? 2 : [self.weaponChoices count];
    for (NSInteger i = 0; i < possibleWeapons; i++) {
        QPWeaponOptionLayer *l = [self.optionLayers objectAtIndex:i];
        [l addWeaponOptionsToLayer:layer];
    }
    
    float screenWidth = 768;
    float spacing = screenWidth / (possibleWeapons + 1);
    float x = spacing;
    for (QPWeaponOptionLayer *l in self.optionLayers) {
        [l positionDisplayAroundLocation:ccp(x,1024/2)];
        x+= spacing;
    }
}

- (void)openWeaponOptions {
    if (!self.weaponChoices) {
        self.weaponChoices = [NSArray arrayWithObjects:self.triLaser, self.splitLaser, self.wideTriLaser, self.sideLaser, nil];
    }
    
    [self displayOptionLayersForWeaponChoices];
}

- (void)chooseWeapon:(NSInteger)choiceIndex {
    Weapon *chosenWeapon = [self.weaponChoices objectAtIndex:choiceIndex];
    [self.chosenWeapons addObject:chosenWeapon];
        
    [self.delegate playerChoseWeapon:chosenWeapon];
    
    NSMutableArray *choices = [NSMutableArray arrayWithArray:self.weaponChoices];
    [choices removeObjectAtIndex:choiceIndex];
    
    Weapon *earliestChosenWeapon = [self.chosenWeapons objectAtIndex:0];
    [choices addObject:earliestChosenWeapon];
    [self.chosenWeapons removeObject:earliestChosenWeapon];
    
    self.weaponChoices = [NSArray arrayWithArray:choices];
}

- (BOOL)presentingOptions {
    return [self.optionLayers count] > 0;
}

- (void)processWeaponSelectionFromLocationTapped:(CGPoint)l {
    float distance = 10000;
    Weapon *chosenWeapon = nil;
    for (QPWeaponOptionLayer *ol in self.optionLayers) {
        float layerDistance = ccpDistance(l, ol.weaponSprite.position);
        if (layerDistance < distance) {
            chosenWeapon = ol.weapon;
            distance = layerDistance;
        }
    }
    
    [self chooseWeapon:[self.weaponChoices indexOfObject:chosenWeapon]];
    
    for (QPWeaponOptionLayer *ol in self.optionLayers) {
        [ol removeDisplay];
    }
    
    [self.optionLayers removeAllObjects];    
}

- (void)dealloc {
    [weaponChoices release];
    [singleLaser release];
    [splitLaser release];
    [triLaser release];
    [quadLaser release];
    [sideLaser release];
    [chosenWeapons release];
    [wideTriLaser release];
    [optionLayers release];
    self.delegate = nil;
    [super dealloc];
}

@end