//
//  GameOverScene.m
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "GameOverScene.h"
#import "GameScene.h"
@implementation GameOverScene
-(id) init {
    self = [super init];
    if (self){
        overLayer = [GameOverLayer node];
        [self addChild:overLayer z:4];
        [overLayer setParentControl:self];
    }
    return self;
}


-(void) startGame{
    [[CCDirector sharedDirector] runWithScene:[GameScene node]];
}

@end
