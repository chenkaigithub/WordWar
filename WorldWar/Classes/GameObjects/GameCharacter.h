//  GameCharacter.h
//  SpaceViking

#import <Foundation/Foundation.h>
#import "GameObject.h"
#import "Defs.h"

@interface GameCharacter : GameObject {
    int characterHealth;
    CharacterStates characterState;
    NSString *enemyPrefix;
}

-(void)checkAndClampSpritePosition; 
-(int)getWeaponDamage;

@property (readwrite) int characterHealth;
@property (readwrite) CharacterStates characterState;
@property (nonatomic, retain) NSString *enemyPrefix;
@end
