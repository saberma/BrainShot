//
//  Ball.m
//  BrainShot
//
//  Created by  cogent on 10-3-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"
#import "cocos2d.h"

static int clicked;

@implementation Ball

@synthesize number, delegate;
@synthesize clickable;

+ (void)clearClicked
{
  clicked = 0;
}

+ (Ball *)withLabel:(int)number AtLeftIndex:(int)leftIndex AndRightIndex:(int)rightIndex
{
  CGSize size = [[CCDirector sharedDirector] winSize];
  int left = (size.width/2 - Ball.size*5) + leftIndex * Ball.size + Ball.size/2;
  int right = (size.height/2 - Ball.size*3.3) + rightIndex * Ball.size + Ball.size/2; 
  
  Ball *ball = [Ball spriteWithFile:@"circle_green.png"];
  ball.position =  ccp( left , right + 2 );
  
  // create and initialize a Label
  CCLabel* label = [CCLabel labelWithString:[NSString stringWithFormat:@"%d", number] fontName:@"Marker Felt" fontSize:32];
  // position the label on the center of the screen
  label.position = ccp(24, 24);
  
  [ball setNumber:number];
  [ball addChild:label];
   
  return ball;
}

+ (int)size{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    return 76.8;
  } else {
    return 48;
  }
#else
  return 48;
#endif
}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] ) return NO;
	if ( ![self clickable] ) return NO;
  
  [self.delegate click:self];
  
	return NO;
}

- (void)show
{
  [self setClickable:false];
  [[self.children objectAtIndex:0] setVisible:TRUE];
}

- (void)hide
{
  [[self.children objectAtIndex:0] setVisible:FALSE];
}

- (BOOL)clickCorrect
{
  if (clicked++ == [self number]) {
    return true;
  } else {
    CCLabel *label = (CCLabel *)[self.children objectAtIndex:0];
    [label setColor:ccORANGE];    
    return false;
  }
}

@end
