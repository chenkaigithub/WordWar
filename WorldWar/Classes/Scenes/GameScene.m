//
//  GameScene.m
//  WorldWar
//
//  Created by Dima on 04.11.12.
//
//

#import "GameScene.h"
#import "StartMenuLayer.h"
@implementation GameScene

-(id) init {
    self = [super init];
    if (self){
        BackgroundLayer* backgroundLAyer = [BackgroundLayer node];
        [self addChild:backgroundLAyer z:0];
        
        gameplayLayer = [GameplayLayer node];
        [self addChild:gameplayLayer z:3];
        [gameplayLayer stopAllActions];
 
    }
    return self;
}



@end
