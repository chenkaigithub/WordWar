//
//  Enemy.h
//  WorldWar
//
//  Created by Dima on 13.04.13.
//
//

#import "GameCharacter.h"

@interface Enemy : GameCharacter{
    NSValue *currentWaypoint;
    int currentWaypointIndex;
    GameCharacter *kingCharacter;
    
    CCAnimation *enemySpawnAnimation;
    CCAnimation *enemyWalkAnimation;
    CCAnimation *enemyWalkDownAnimation;
    CCAnimation *enemyDyingAnimation;
    CCAnimation *enemyAtackAnimation;
    CCAnimation *enemyEatenAnimation;
    
   id <GameplayLayerDelegate> delegate;
}

@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;

@property (nonatomic, retain) CCAnimation *enemySpawnAnimation;
@property (nonatomic, retain) CCAnimation *enemyWalkAnimation;
@property (nonatomic, retain) CCAnimation *enemyWalkDownAnimation;
@property (nonatomic, retain) CCAnimation *enemyDyingAnimation;
@property (nonatomic, retain) CCAnimation *enemyAtackAnimation;
@property (nonatomic, retain) CCAnimation *enemyEatenAnimation;

@property (nonatomic,assign) float movingSpeedKoef;

-(void) initAnimations;
@end
