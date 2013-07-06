//
//  GameOverLayer.h
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
@interface GameOverLayer : CCLayer{
    CCLayer *menuLayer;
    id control;
}

-(void) setParentControl:(id) _control;

@end
