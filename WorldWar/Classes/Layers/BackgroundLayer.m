//
//  BackgroundLayer.m
//  WorldWar
//
//  Created by Dima on 04.11.12.
//
//

#import "Defs.h"
#import "BackgroundLayer.h"

@implementation BackgroundLayer


-(id) init {
    self = [super init];
    if (self){
        CCSprite* backgroundImage = [CCSprite spriteWithFile:@"background.png" rect:CGRectMake(0, 0, screenWidth,screenHeight)];
        [backgroundImage setPosition:CGPointMake(screenWidth/2, screenHeight/2)];
         [self addChild:backgroundImage z:0 tag:0];
    }
    return self;
}


@end
