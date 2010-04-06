//
//  MenuScene.m
//  BrainShot
//
//  Created by  saberma on 10-4-6.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#import "MenuLayer.h"


@implementation MenuScene

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    [self addChild:[MenuLayer node]];
	}
	return self;
}
@end
