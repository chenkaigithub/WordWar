//
//  GameplayLayer.m
//  WorldWar
//
//  Created by Dima on 04.11.12.
//
//

#import "GameplayLayer.h"
#import "Defs.h"
#import "Logging.h"
#import "AppDelegate.h"
@implementation GameplayLayer

#define enemiesAppearenceInterval 3
#define reqLettersCount 10

-(id) init{
    self = [super init];
    if (self){
        self.isTouchEnabled = YES;
        enemiesArray = [[NSMutableArray alloc] init];
        [self initHeroes];
        [self scheduleUpdate];
        
        lastWalkingFrame = 1;
    }
    return self;
}

//====================

-(void) addEnemy{
    Enemy *enemy = [[Enemy alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"spawn1.png"]];
    int randomNumber = arc4random() % 4;
    enemy.enemyPrefix = randomNumber>1?[NSString stringWithFormat:@"%d",randomNumber]:@"";
    [enemy initAnimations];
    [enemy setPosition:ccp(50, screenHeight+150)];
    [sceneSpriteBatchNode addChild:enemy z:kEnemySpriteZValue tag:kEnemySpriteTagValue];
    [enemiesArray insertObject:enemy atIndex:0];
    [enemy changeState:kStateSpawning];
}

//====================

-(void) addKing {
    king = [[King alloc] initWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"kingIdle1.png"]];
    [king setPosition:ccp(screenWidth-60, 450)];
    [sceneSpriteBatchNode addChild:king z:kKingSpriteZValue tag:kKingCharacterTag];How to check in app, application running device has manually installed google maps or not?
    [king changeState:kStateIdle];
}

//====================

-(void) initHeroes {
    [[CCSpriteFrameCache sharedSpriteFrameCache]
    addSpriteFramesWithFile:@"Enemies.plist"];
    sceneSpriteBatchNode = [CCSpriteBatchNode batchNodeWithFile:@"Enemies.png"];
    [self addChild:sceneSpriteBatchNode z:0];
    
    enemiesApperenceTimer = [NSTimer scheduledTimerWithTimeInterval:enemiesAppearenceInterval target:self selector:@selector(addEnemy) userInfo:nil repeats:YES];
    [self addKing];
    
    enemyShotProgress = [[ProgressView alloc] initWithFrame:CGRectMake(20, 20, 150, 30)];
    [[[CCDirector sharedDirector] view] addSubview:enemyShotProgress];
    [enemyShotProgress setSideText:[NSString stringWithFormat:@"%d/%d",0,reqLettersCount]];
    [enemyShotProgress setProgressPercentage:0.3];
    
    textView = [[TextLineView alloc] initWithFrame:CGRectMake(0, 768-392, screenWidth, 40)];
    [[[CCDirector sharedDirector] view] addSubview:textView];
    [textView highlightNormalChar];
    [APP_DELEGATE.textProcessor setDelegate:self];
}


//====================

-(void) update:(ccTime)deltaTime{
    CCArray *listOfGameObjects = [sceneSpriteBatchNode children];
    if (king.characterState == kStateDead && (![king numberOfRunningActions] > 0)){
        
        [enemiesApperenceTimer invalidate];
        [self unscheduleUpdate];
        for (GameCharacter *tempChar in listOfGameObjects) {
            if (tempChar!=king){
                [tempChar stopAllActions];
                //[tempChar changeState:kStateDying];
            }
        }
        gameOver = YES;
        [self performSelector:@selector(makeGameOver) withObject:nil afterDelay:3];
        return;
    }
    
        NSMutableArray *arrayToRemove = [NSMutableArray array];
        for (GameCharacter *tempChar in listOfGameObjects) {
            [tempChar updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];
            if (tempChar.characterState == kStateDead && (![tempChar numberOfRunningActions] > 0)){
                [arrayToRemove addObject:tempChar];
            }
        }
        for (GameCharacter *tempChar in arrayToRemove){
            if (tempChar != king){
                [enemiesArray removeObject:tempChar];
                [tempChar removeFromParentAndCleanup:YES];
            }
        }
        [king updateStateWithDeltaTime:deltaTime andListOfGameObjects:listOfGameObjects];
}

//====================

-(void) pointAdded {
    if (!gameOver){
        int currentProgress = [enemyShotProgress progress];
        currentProgress++;
        if (currentProgress == reqLettersCount){
            currentProgress = 0;
            Enemy* enemy = (Enemy*)[enemiesArray lastObject];
            [enemy changeState:kStateDying];
        }
        [enemyShotProgress setProgressPercentage:currentProgress];
        [enemyShotProgress setSideText:[NSString stringWithFormat:@"%d/%d",currentProgress,reqLettersCount]];
    }
}

//====================

-(void) pointSubstracted {
    if (!gameOver){
        int currentProgress = [enemyShotProgress progress];
        currentProgress--;
        if (currentProgress < 0){
            currentProgress = 0;
        }
        [enemyShotProgress setProgressPercentage:currentProgress];
        [enemyShotProgress setSideText:[NSString stringWithFormat:@"%d/%d",currentProgress,reqLettersCount]];
    }
}

//====================

-(void) makeGameOver {
    [APP_DELEGATE gameOver];
}

//====================
//====================
//====================
//====================
//====================
//====================

- (void)dealloc
{
    [enemiesArray release];
    [super dealloc];
}

@end
