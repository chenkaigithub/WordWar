//
//  StartMenuLayer.m
//  WorldWar
//
//  Created by Dima on 14.04.13.
//
//

#import "StartMenuLayer.h"
#import "Defs.h"
#import "GameScene.h"

@implementation StartMenuLayer

-(id) init{
    self = [super init];
    if (self){
        [self initControls];
    }
    return self;
}


-(void) initControls{
    CCSprite* backgroundImage = [CCSprite spriteWithFile:@"introBackground.png" rect:CGRectMake(0, 0, screenWidth,screenHeight)];
    [backgroundImage setPosition:CGPointMake(screenWidth/2, screenHeight/2)];
    [self addChild:backgroundImage z:0 tag:0];
    
    menuLayer = [[CCLayer alloc] init];
    [self addChild:menuLayer z:50];
//    [menuLayer setPosition:CGPointMake(screenWidth/2, 50)];
    
    CCMenuItemImage *startButton = [CCMenuItemImage
                                    itemFromNormalImage:@"PlayInactive.png"
                                    selectedImage:@"PlayActive.png"
                                    target:self
                                    selector:@selector(startGame:)];
    
    CCMenu *menu = [CCMenu menuWithItems: startButton, nil];
    [menu setPosition:CGPointMake(screenWidth-150, 100)];
    [menuLayer addChild: menu];
    
}

-(void) startGame:(id) sender{
    [(GameScene*)control startGame];
}

-(void) setParentControl:(id) _control{
    control = _control;
}

@end
