//
//  LevelScene.m
//  BrainShot
//
//  Created by  cogent on 10-3-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelScene.h"


@implementation LevelScene

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
    
    // create and initialize a Label
    CCLabel* label = [CCLabel labelWithString:[NSString stringWithFormat:@"Level %d", [Level current]] fontName:@"Marker Felt" fontSize:48];
    // position the label on the center of the screen
    label.position = ccp(size.width/2, size.height/2);
    
    [self addChild:label];
    
    id sequence = [CCSequence actions:[CCDelayTime actionWithDuration:1], [CCCallFuncN actionWithTarget:self selector:@selector(finished)], nil];
    [self runAction:sequence];
	}
	return self;
}

- (void)finished
{
  [[CCDirector sharedDirector] replaceScene:[HelloWorld scene]];
}
@end
