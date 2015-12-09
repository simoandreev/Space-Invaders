//
//  Ball.h
//  Space Invaders
//
//  Created by Simeon Andreev on 12/9/15.
//  Copyright © 2015 developer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Ball : SKSpriteNode

@property (nonatomic) SKEmitterNode *trail;
@property (nonatomic) int bounces;

-(void)updateTrail;

@end
