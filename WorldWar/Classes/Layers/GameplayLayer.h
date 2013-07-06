//
//  GameplayLayer.h
//  WorldWar
//
//  Created by Dima on 04.11.12.
//
//

#import "CCLayer.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TextLineView.h"
#import "Enemy.h"
#import "King.h"
#import "TextProcessor.h"
#import "ProgressView.h"

@interface GameplayLayer : CCLayer <TextProcessorDelegate>{
    
    NSTimer *enemiesApperenceTimer;
    
    ProgressView *enemyShotProgress;
    
    TextLineView *textView;
    
    CCSprite* fighterSprite;
    CCSpriteBatchNode* batchNode;
    CCSpriteBatchNode* sceneSpriteBatchNode;
    int lastWalkingFrame;
    
    
    //tmp delete later
    CCSprite* fightingMan;
    CCSprite* enemySprite;
    CCAnimate* animationAction;
    King *king;
    NSMutableArray *enemiesArray;
    
    BOOL gameOver;
}

-(void) addEnemy;


@end
