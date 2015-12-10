//
//  GameScene.h
//  Space Invaders
//

//  Copyright (c) 2015 г. developer. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) int ammo;
@property (nonatomic) int score;
@property (nonatomic, strong) NSNumber *_bufferValueForScore;
@property (nonatomic) int pointValue;
@property (nonatomic) BOOL multiMode;
@property (nonatomic) BOOL gamePaused;

@end
