//
//  GameScene.h
//  Space Invaders
//

//  Copyright (c) 2015 г. developer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) int ammo;
@property (nonatomic) int score;
@property (nonatomic, strong) NSNumber *_bufferValueForScore;

@end
