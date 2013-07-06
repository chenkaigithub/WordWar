//
//  AppDelegate.h
//  WorldWar
//
//  Created by Dima on 03.11.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "TextProcessor.h"
@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    TextProcessor *textProcessor;
    NSArray *waypoints;
    NSArray *enemiesPrefixes;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSArray *waypoints;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic, retain) TextProcessor *textProcessor;

-(NSArray*) enemiesPrefixes;

-(void) gameOver;

@end
