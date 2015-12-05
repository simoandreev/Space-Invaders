//
//  GameScene.m
//  Space Invaders
//
//  Created by Simeon Andreev on 5.12.15 г..
//  Copyright (c) 2015 г. developer. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {

SKNode *_mainLayer;
SKSpriteNode *_cannon;
BOOL didShot;
}
static const CGFloat SHOOT_SPEED = 1000.0;
static const CGFloat kCCHaloLowAngle = 200.0 * M_PI / 180.0;
static const CGFloat kCCHaloHighAngle = 340.0 * M_PI / 180.0;
static const CGFloat kCCHaloSpeed = 100.0;

static inline CGVector radiansToVector(CGFloat radians)
{
    CGVector vector;
    vector.dx = cosf(radians);
    vector.dy = sinf(radians);
    return vector;
}

static inline CGFloat randomInRange(CGFloat low, CGFloat high)
{
    CGFloat value = arc4random_uniform(UINT32_MAX) / (CGFloat)UINT32_MAX;
    return value * (high - low) + low;
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
   
    // Add background.
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Starfield"];
    background.size = self.frame.size;
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.blendMode = SKBlendModeReplace;
    [self addChild:background];
    
    // Add main layer.
    _mainLayer = [[SKNode alloc] init];
    [self addChild:_mainLayer];
    
    // Add cannon.
    _cannon = [SKSpriteNode spriteNodeWithImageNamed:@"Cannon"];
    _cannon.position = CGPointMake(self.size.width * 0.5, 0.0);
    [_mainLayer addChild:_cannon];
    
    // Create cannon rotation actions.
    SKAction *rotateCannon = [SKAction sequence:@[[SKAction rotateByAngle:M_PI duration:2],
                                                  [SKAction rotateByAngle:-M_PI duration:2]]];
    [_cannon runAction:[SKAction repeatActionForever:rotateCannon]];
    
    // Turn off gravity.
    self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
    
    // Add edges.
    SKNode *leftEdge = [[SKNode alloc] init];
    leftEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointZero toPoint:CGPointMake(0.0, self.size.height)];
    leftEdge.position = CGPointZero;
    [self addChild:leftEdge];
    SKNode *rightEdge = [[SKNode alloc] init];
    rightEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointZero toPoint:CGPointMake(0.0, self.size.height)];
    rightEdge.position = CGPointMake(self.size.width, 0.0);
    [self addChild:rightEdge];
}

-(void)shoot
{
    // Create ball node.
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
    CGVector rotationVector = radiansToVector(_cannon.zRotation);
    ball.position = CGPointMake(_cannon.position.x + (_cannon.size.width   * rotationVector.dx),
                                _cannon.position.y + (_cannon.size.width * 0.5 * rotationVector.dy));
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:6.0];
    ball.physicsBody.velocity = CGVectorMake(rotationVector.dx * SHOOT_SPEED, rotationVector.dy * SHOOT_SPEED);
    ball.name = @"ball";
    ball.physicsBody.restitution = 1.0;
    ball.physicsBody.linearDamping = 0.0;
    ball.physicsBody.friction = 0.0;
    
    [_mainLayer addChild:ball];
}

-(void)spawnHalo
{
    // Create halo node.
    SKSpriteNode *halo = [SKSpriteNode spriteNodeWithImageNamed:@"Halo"];
    halo.position = CGPointMake(randomInRange(halo.size.width * 0.5, self.size.width - (halo.size.width * 0.5)),
                                self.size.height + (halo.size.height * 0.5));
    halo.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:16.0];
    CGVector direction = radiansToVector(randomInRange(kCCHaloLowAngle, kCCHaloHighAngle));
    halo.physicsBody.velocity = CGVectorMake(direction.dx * kCCHaloSpeed, direction.dy * kCCHaloSpeed);
    halo.physicsBody.restitution = 1.0;
    halo.physicsBody.linearDamping = 0.0;
    halo.physicsBody.friction = 0.0;
    [_mainLayer addChild:halo];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        didShot = YES;
//        CGPoint location = [touch locationInNode:self];
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didSimulatePhysics
{
    if (didShot) {
        [self shoot];
        [self spawnHalo];
        didShot = NO;
    }
    
    // Remove unused nodes.
    [_mainLayer enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
        if (!CGRectContainsPoint(self.frame, node.position)) {
            [node removeFromParent];
        }
    }];
}

@end
