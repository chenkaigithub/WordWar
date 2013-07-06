//
//  StartScene.m
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "StartScene.h"
#import "GameScene.h"
@implementation StartScene
-(id) init {
    self = [super init];
    if (self){
         startLayer = [StartMenuLayer node];
        [self addChild:startLayer z:4];
        [startLayer setParentControl:self];
    }
    return self;
}


-(void) startGame{
        [[CCDirector sharedDirector] runWithScene:[GameScene node]];
 }

 
@end
