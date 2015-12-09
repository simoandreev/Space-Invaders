//
//  Ball.m
//  Space Invaders
//
//  Created by Simeon Andreev on 12/9/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import "Ball.h"

@implementation Ball

-(void)updateTrail
{
    if (self.trail) {
        self.trail.position = self.position;
    }
}
-(void)removeFromParent
{
    if (self.trail) {
        self.trail.particleBirthRate = 0.0;
        SKAction *removeTrail = [SKAction sequence:@[[SKAction waitForDuration:self.trail.particleLifetime
                                                      + self.trail.particleLifetimeRange],
                                                     [SKAction removeFromParent]]];
        [self runAction:removeTrail];
    }
    [super removeFromParent];
}

@end
