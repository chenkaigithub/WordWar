//
//  Enemy.m
//  WorldWar
//
//  Created by Dima on 13.04.13.
//
//

#import "Enemy.h"
#import "Defs.h"
#import "Logging.h"
#import "AppDelegate.h"

@implementation Enemy
@synthesize enemySpawnAnimation;
@synthesize enemyWalkAnimation;
@synthesize movingSpeedKoef;
@synthesize enemyDyingAnimation;
@synthesize enemyWalkDownAnimation;
@synthesize enemyEatenAnimation;
@synthesize enemyAtackAnimation;


#define rollBorderDiff 5
#define oneWaypointWalkTime 1.2
#define spawnTime 1


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
        currentWaypointIndex = 0;
        self.enemyPrefix = @"";
        [self initAnimations];
    }
    return self;

}

-(int)getWeaponDamage {
    
    return 1;
}

//====================

-(void)changeState:(CharacterStates)newState {
    kingCharacter = (GameCharacter*)[[self parent] getChildByTag:kKingCharacterTag];
   // if (characterState == kStateDead)
   //     return;
    
    [self stopAllActions];
    id action = nil;
    characterState = newState;
    
    switch (newState) {
        case kStateIdle:{
            
        }
            break;
            
        case kStateSpawning:{
            
            id moveAction = [CCMoveTo actionWithDuration:spawnTime position:[[APP_DELEGATE.waypoints objectAtIndex:0] CGPointValue]];
            id easeAction = [CCEaseElastic actionWithAction:moveAction];
            action = [CCSpawn actions:
                      [CCAnimate actionWithAnimation:self.enemySpawnAnimation],
                      [CCScaleTo actionWithDuration:0.6 scale:0.35],
                      easeAction,
                      nil];
        }
            break;
            //--------------
        case kStateWalk:{
            
            CCAnimate* walkAnimationAction = [CCAnimate actionWithAnimation:self.enemyWalkAnimation];
            id atlasRepeatAction = [CCRepeatForever actionWithAction:walkAnimationAction];
            id moveAction = [CCMoveTo actionWithDuration:oneWaypointWalkTime*self.movingSpeedKoef position:[[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue]];
            id easeAction = [CCEaseElastic actionWithAction:moveAction];
            [self runAction:atlasRepeatAction];
            action = [CCSpawn actions:
                      easeAction,
                      nil];
        }
            break;
            
            //--------------
        case kStateWalkUp:{
           [self changeState:kStateWalk];
        }
            break;
            //--------------
        case kStateWalkDown:{

            CCAnimate* walkAnimationAction = [CCAnimate actionWithAnimation:self.enemyWalkDownAnimation];
            id atlasRepeatAction = [CCRepeatForever actionWithAction:walkAnimationAction];
            id moveAction = [CCMoveTo actionWithDuration:oneWaypointWalkTime*self.movingSpeedKoef position:[[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue]];
            id easeAction = [CCEaseElastic actionWithAction:moveAction];
            [self runAction:atlasRepeatAction];
            action = [CCSpawn actions:
                      easeAction,
                      nil];
        }
            break;
            
            //--------------
        case kStateContactingWithKing:{
            kingCharacter.enemyPrefix = self.enemyPrefix;
            if (kingCharacter.characterHealth>0){
                [self changeState:kStateEated];
            }
            else {
                [self changeState:kStateAttacking];
            }
            [kingCharacter changeState:kStateTakingDamage];
        }
            break;
            //--------------
        case kStateEated:{
            CCAnimate* eatenAnimationAction = [CCAnimate actionWithAnimation:self.enemyEatenAnimation];
            id moveToDie = [CCMoveTo actionWithDuration:0.2  position: ccp(self.position.x-40,self.position.y-40)];
            id easeAction = [CCEaseElastic actionWithDuration:4.5];
            id sequence = [CCSequence actions:eatenAnimationAction, moveToDie, easeAction,nil];
            action = [CCSpawn actions:
                      sequence,
                      nil];
        }
            break;
            //--------------
        case kStateDying:{
            id rollDownAction = [CCAnimate actionWithAnimation:self.enemyWalkDownAnimation];
            id dieAction = [CCAnimate actionWithAnimation:self.enemyDyingAnimation];
            id sequence = [CCSequence actions:rollDownAction, dieAction,nil];
            id moveToDie = [CCMoveTo actionWithDuration:2  position: ccp(self.position.x,410)];
            id easeAction = [CCEaseElastic actionWithAction:moveToDie];

            action = [CCSpawn actions:
                      sequence,
                      easeAction,
                      nil];
        }
            break;
            //--------------
        case kStateAttacking:{
            CCAnimate* atackAnimationAction = [CCAnimate actionWithAnimation:self.enemyAtackAnimation];
            action = [CCSpawn actions:
                      atackAnimationAction,
                      nil];

        }
            break;
        case kStateDead:{
            action = [CCFadeOut actionWithDuration:0.2];
        }
            break;
        
        default:
            CCLOG(@"Enemy  -> Unknown state %d", characterState);

            break;
    }
    
    if (action != nil)
        [self runAction:action];
}

//====================

-(void)updateStateWithDeltaTime:(ccTime)deltaTime andListOfGameObjects:(CCArray*)listOfGameObjects {
    
    if (self.characterState == kStateDead)
        return; // Nothing to do if evenmy is dead
    
    if ((self.characterState == kStateAttacking || self.characterState == kStateDying) && ([self numberOfRunningActions] > 0)){
        return; // Currently playing some of non breakable animation
    }
    
    
    switch (self.characterState) {
        case kStateSpawning:{
            if (CGPointEqualToPoint(self.position,[[APP_DELEGATE.waypoints objectAtIndex:0] CGPointValue]) == YES){
                // Not playing an animation
                 if ([self numberOfRunningActions] == 0) {
                    currentWaypointIndex++;
                    [self changeState:kStateWalk];

                }
            }
        }
            break;
        //--------------
        case kStateWalk:{
            if (CGPointEqualToPoint(self.position,[[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue]) == YES){
                currentWaypointIndex++;
                if (currentWaypointIndex==[APP_DELEGATE.waypoints count]){
                    [self changeState:kStateContactingWithKing];
                }
                else if ((self.position.y +rollBorderDiff) < [[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue].y){
                    [self changeState:kStateWalkUp];
                }
                else if ((self.position.y-rollBorderDiff) > [[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue].y){
                    [self changeState:kStateWalkDown];
                }
                else [self changeState:kStateWalk];
            }
        }
            break;
        //--------------
        case kStateWalkUp:{
            if (CGPointEqualToPoint(self.position,[[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue]) == YES){
                currentWaypointIndex++;
                if (currentWaypointIndex==[APP_DELEGATE.waypoints count]){
                    [self changeState:kStateContactingWithKing];
                }
                else if ((self.position.y-rollBorderDiff) > [[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue].y){
                    [self changeState:kStateWalkDown];
                }
            }
        }
            break;
        //--------------
        case kStateWalkDown:{
            if (CGPointEqualToPoint(self.position,[[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue]) == YES){
                currentWaypointIndex++;
                if (currentWaypointIndex==[APP_DELEGATE.waypoints count]){
                    [self changeState:kStateContactingWithKing];
                }
                else if ((self.position.y+rollBorderDiff) < [[APP_DELEGATE.waypoints objectAtIndex:currentWaypointIndex] CGPointValue].y){
                    [self changeState:kStateWalkUp];
                }
                else [self changeState:kStateWalk];
            }
        }
            break;
        //--------------
        case kStateContactingWithKing:{
            if (kingCharacter.characterHealth>0){
                [self changeState:kStateEated];
            }
            else {
                [self changeState:kStateAttacking];
            }
        }
            break;
         //--------------
        case kStateEated:{
            if ([self numberOfRunningActions] == 0) {
                [self changeState:kStateDead];
            }
        }
            break;
        //--------------
        case kStateDying:{
            if (![self numberOfRunningActions] > 0){
                [self changeState:kStateDead];
            }
        }
            break;
        //--------------
        case kStateAttacking:{
            
        }
            break;
        case kStateDead:{
            if (![self numberOfRunningActions] > 0){
                [self parent];
            }
        }
            break;
        default:
            break;
    }
    
}

//====================

#pragma mark -
#pragma mark initAnimations
-(void)initAnimations {
    self.movingSpeedKoef = 1;
    
    self.enemyWalkAnimation = [self loadPlistForAnimationWithName:@"walkAnimation" andClassName:NSStringFromClass([self class]) withPrefix:self.enemyPrefix];
    self.enemySpawnAnimation = [self loadPlistForAnimationWithName: @"spawnAnimation" andClassName:NSStringFromClass([self class])withPrefix:self.enemyPrefix];
    self.enemyWalkDownAnimation = [self loadPlistForAnimationWithName:@"walkDownAnimation" andClassName:NSStringFromClass([self class])withPrefix:self.enemyPrefix];
    self.enemyDyingAnimation = [self loadPlistForAnimationWithName:@"dyingAnimation" andClassName:NSStringFromClass([self class])withPrefix:self.enemyPrefix];
    self.enemyAtackAnimation = [self loadPlistForAnimationWithName:@"atackAnimation" andClassName:NSStringFromClass([self class])withPrefix:self.enemyPrefix];
    self.enemyEatenAnimation = [self loadPlistForAnimationWithName:@"eatenAnimation" andClassName:NSStringFromClass([self class])withPrefix:self.enemyPrefix];
}

//====================
             
-(void) dealloc {
     delegate = nil;
    self.enemyWalkDownAnimation = nil;
    self.enemyDyingAnimation = nil;
    self.enemySpawnAnimation = nil;
    self.enemyWalkAnimation = nil;
    self.enemyPrefix = nil;
    self.enemyAtackAnimation = nil;
    self.enemyEatenAnimation = nil;
    
     [super dealloc];
}
             
@end
