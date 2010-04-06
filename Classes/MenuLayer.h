//
//  MenuLayer.h
//  BrainShot
//
//  Created by  saberma on 10-4-6.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LevelScene.h"
#import "Level.h"


@interface MenuLayer  : CCLayer {

}

-(void) reset:(id)sender;
-(void) continueMax:(id)sender;
-(void) returnCurrent:(id)sender;
@end
