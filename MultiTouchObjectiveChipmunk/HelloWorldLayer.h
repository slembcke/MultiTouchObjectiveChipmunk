//
//  HelloWorldLayer.h
//  MultiTouchObjectiveChipmunk
//
//  Created by Scott Lembcke on 11/27/12.
//  Copyright Howling Moon Software 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
