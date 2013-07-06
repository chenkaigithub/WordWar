//
//  King.m
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "King.h"
#import "Defs.h"
#import "AppDelegate.h"
@implementation King
@synthesize kingDieAnimation, kingEatEnemyAnimation, kingIdleAnimation;
@synthesize delegate;
@synthesize health;
@synthesize kingFullAnimation;
- (id)init
{
    self = [super init];
    if (self) {
        [self initAnimations];
    }
    return self;
}

-(id) initWithSpriteFrame:(CCSpriteFrame *)spriteFrame {
    self = [super initWithSpriteFrame:spriteFrame];
    if (self) {
        self.characterHealth = 3;
        self.enemyPrefix = @"";
        dyingAnimations = [[NSMutableDictionary alloc] init];
        [self initAnimations];
    }
    return self;
    
}

-(int)getWeaponDamage {
    
    return 1;
}

//====================

-(void)changeState:(CharacterStates)newState {

    [self stopAllActions];
    id action = nil;
    characterState = newState;
    
    switch (newState) {
        case kStateIdle:{
            CCAnimate* idleAnimationAction = [CCAnimate actionWithAnimation:self.kingIdleAnimation];
            action = [CCRepeatForever actionWithAction:idleAnimationAction];
        }
            break;
            //--------------
        case kStateEat:{
            
            CCAnimate* eatAnimationAction = [CCAnimate actionWithAnimation:self.kingEatEnemyAnimation];
            action = [CCSpawn actions:
                      eatAnimationAction,
                      nil];
            self.characterHealth--;
            if (self.characterHealth <=0){
                CCAnimate* fullAnimationAction = [CCAnimate actionWithAnimation:self.kingFullAnimation];
                id sequence = [CCSequence actions:eatAnimationAction, fullAnimationAction, nil];
//                [self runAction:sequence];
                action = sequence;
            }
        }
            break;
            
            //--------------
        case kStateTakingDamage:{
            if (self.characterHealth>0) {
                [self changeState:kStateEat];
            }
            else {
                [self changeState:kStateDying];
            }
            
        }
            break;
            //--------------
        case kStateDying:{

            CCAnimate* dyingAnimationAction = [CCAnimate actionWithAnimation:[dyingAnimations objectForKey:self.enemyPrefix]];
            action = [CCSpawn actions:
                      dyingAnimationAction,
                      nil];
        }
            break;
            
            //--------------
        case kStateDead:{
            
        }
            break;
            //--------------
            
        default:
            CCLOG(@"Enemy  -> Unknown state %d", characterState);
            
            break;
    }
    
    if (action != nil)
        [self runAction:action];
}

//====================

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects {
    
    if (self.characterState == kStateDead || self.characterState == kStateIdle)
        return; // Nothing to do if evenmy is dead
    
    if ((self.characterState == kStateEat || self.characterState == kStateDying) &&
        ([self numberOfRunningActions] > 0))
        return; // Currently playing some of non breakable animation
    
    
    switch (self.characterState) {
        case kStateTakingDamage:{
                // Not playing an animation
                if ([self numberOfRunningActions] == 0) {
                    if (self.characterHealth>0) {
                        [self changeState:kStateEat];
                    }
                    else {
                        [self changeState:kStateDying];
                    }
            }
        }
            break;
            //--------------
        case kStateEat:{
            if ([self numberOfRunningActions] == 0) {
                if (self.characterHealth>0){
                    [self changeState:kStateIdle];
                }
            }
        }
            break;
            //--------------
        case kStateDying:{
            if ([self numberOfRunningActions] == 0) {
                [self changeState:kStateDead];
            }
        }
            break;
            //--------------
        default:
            break;
    }
}

//====================

#pragma mark -
#pragma mark initAnimations
-(void)initAnimations {
    
    NSArray *enemiesPrefixes = [APP_DELEGATE enemiesPrefixes];
    for (NSString *prefix in enemiesPrefixes) {
        
        CCAnimation *animation = [self loadPlistForAnimationWithName:@"dieAnimation" andClassName:NSStringFromClass([self class])withPrefix:prefix];
        [dyingAnimations setObject:animation forKey:prefix];
    }
    self.kingEatEnemyAnimation = [self loadPlistForAnimationWithName:@"eatAnimation" andClassName:NSStringFromClass([self class])withPrefix:nil];
    self.kingIdleAnimation = [self loadPlistForAnimationWithName:@"idleAnimation" andClassName:NSStringFromClass([self class])withPrefix:nil];
    self.kingFullAnimation = [self loadPlistForAnimationWithName:@"fullAnimation" andClassName:NSStringFromClass([self class])withPrefix:nil];
}

//====================

- (void)dealloc
{
    self.kingEatEnemyAnimation = nil;
    self.kingDieAnimation = nil;
    self.enemyPrefix = nil;
    self.kingFullAnimation = nil;
    [dyingAnimations release];
    [super dealloc];
}

@end
