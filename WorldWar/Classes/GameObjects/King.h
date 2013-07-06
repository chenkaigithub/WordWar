//
//  King.h
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "GameCharacter.h"

@interface King : GameCharacter {
    int health;
    CCAnimation *kingEatEnemyAnimation;
    CCAnimation *kingDieAnimation;
    CCAnimation *kingIdleAnimation;
    CCAnimation *kingFullAnimation;

    
    NSMutableDictionary *dyingAnimations;
    
    id <GameplayLayerDelegate> delegate;
}

@property (nonatomic,assign) id <GameplayLayerDelegate> delegate;

@property (nonatomic, retain) CCAnimation *kingDieAnimation;;
@property (nonatomic, retain) CCAnimation *kingEatEnemyAnimation;
@property (nonatomic, retain) CCAnimation *kingIdleAnimation;
@property (nonatomic, retain) CCAnimation *kingFullAnimation;
@property (nonatomic,assign) int health;

@end