//
//  GameScene.h
//  WorldWar
//
//  Created by Dima on 04.11.12.
//
//

#import "CCScene.h"
#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "GameplayLayer.h"
#import "StartMenuLayer.h"

@interface GameScene : CCScene{
    GameplayLayer* gameplayLayer;
}

@end
