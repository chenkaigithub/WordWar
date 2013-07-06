//
//  Defs.h
//  WorldWar
//
//  Created by Dima on 04.11.12.
//
//

#ifndef WorldWar_Defs_h
#define WorldWar_Defs_h

#define screenWidth 1024
#define screenHeight 768

#define kEnemySpriteZValue 100
#define kEnemySpriteTagValue 50

#define kKingCharacterTag 777
#define kKingSpriteZValue 99

#define highlightedLetterNumber 37
#define APP_DELEGATE ((AppController *)[UIApplication sharedApplication].delegate)

typedef enum {
    kStateDead,
    kStateSpawning,
    kStateWalkDown,
    kStateWalkUp,
    kStateStandingUp,
    kStateWalk,
    kStateAttacking,
    kStateContactingWithKing,
    kStateTakingDamage,
    kStateEated,
    kStateDying,
    kStateEat,
    kStateIdle
} CharacterStates;


typedef enum {
    kObjectTypeNone,
    kPowerUpTypeKing,
    kDiggerType
} GameObjectType;


@protocol GameplayLayerDelegate
-(void)createObjectOfType:(GameObjectType)objectType
               withHealth:(int)initialHealth
               atLocation:(CGPoint)spawnLocation
               withZValue:(int)ZValue;
@end

#endif
