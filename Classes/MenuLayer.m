//
//  MenuLayer.m
//  BrainShot
//
//  Created by  saberma on 10-4-6.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"


@implementation MenuLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    
    CCLabel *resetLabel = [CCLabel labelWithString:NSLocalizedString(@"reset", nil) fontName:@"Marker Felt" fontSize:32];
    CCLabel *continueLabel = [CCLabel labelWithString:NSLocalizedString(@"continue", nil) fontName:@"Marker Felt" fontSize:32];
    CCLabel *returnLabel = [CCLabel labelWithString:NSLocalizedString(@"return", nil) fontName:@"Marker Felt" fontSize:32];
    
    CCMenuItemLabel *resetMenu = [CCMenuItemLabel itemWithLabel:resetLabel target:self selector:@selector(reset:)];
    CCMenuItemLabel *continueMenu = [CCMenuItemLabel itemWithLabel:continueLabel target:self selector:@selector(continueMax:)];
    CCMenuItemLabel *returnMenu = [CCMenuItemLabel itemWithLabel:returnLabel target:self selector:@selector(returnCurrent:)];
    
    CCMenu *menu = [CCMenu menuWithItems:resetMenu, continueMenu, returnMenu, nil];
    [menu alignItemsVertically];
		[self addChild:menu];
	}
	return self;
}

-(void) reset:(id)sender
{
  [Level reset];
  [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
}

-(void) continueMax:(id)sender
{
  [Level gotoMax];
  [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
}

-(void) returnCurrent:(id)sender
{
  [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
}


@end
