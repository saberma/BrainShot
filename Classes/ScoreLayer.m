//
//  ScoreLayer.m
//  BrainShot
//
//  Created by  cogent on 10-3-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScoreLayer.h"


@implementation ScoreLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    CCLabel* label = [CCLabel labelWithString:[NSString stringWithFormat:@"Level %d", [Level current]] fontName:@"Marker Felt" fontSize:12];
		CGSize size = [[CCDirector sharedDirector] winSize];
    label.position = ccp(size.width/2, 302);
    [self addChild:label];
	}
	return self;
}
@end
