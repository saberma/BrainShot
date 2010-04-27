//
//  BallLayer.m
//  BrainShot
//
//  Created by  cogent on 10-4-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
// Import the interfaces
#import "BallLayer.h"

@implementation BallLayer

@synthesize balls, positions, level;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    
		// ask director the the window size
		//CGSize size = [[CCDirector sharedDirector] winSize];
    
    NSMutableArray *tmpPositions = [[NSMutableArray alloc] init];
    for (int left=0; left<10; left++) {
      for (int right=0; right<6; right++) {
        Position *position = [Position atLeft:left andRight:right];
        [tmpPositions addObject:position];
      }
    }
    [self setPositions:tmpPositions];
    [tmpPositions release];
    
    [self setLevel:1];
    [self start];
	}
	return self;
}

-(void) start
{
  [self removeAllChildrenWithCleanup:YES];
  [Ball clearClicked];
  
  NSMutableArray *tmpBalls = [[NSMutableArray alloc] init];
  NSMutableArray *tmpPositions = [self.positions mutableCopy];
  
  for (int number=0; number<[Level current]; number++) {
    int rand = arc4random() % [tmpPositions count];
    Position *position = [tmpPositions objectAtIndex:rand];
    [tmpPositions removeObjectAtIndex:rand];
    Ball *ball = [Ball withLabel:number AtLeftIndex:position.left AndRightIndex:position.right];
    [ball setDelegate:self];
    [tmpBalls addObject:ball];
    [self addChild:ball];
  }
  [self setBalls:tmpBalls];
  
  [tmpPositions release];
  [tmpBalls release];
  [self schedule:@selector(hide:) interval:([Level current]  * 0.7f)];
}

-(void) hide: (ccTime) dt
{
  [self unschedule:_cmd];
  for (Ball *ball in self.balls) {
    [ball hide];
  }
  for (Ball *ball in self.balls) {
    [ball setClickable:true];
  }
}

-(void) restart: (ccTime) dt
{
  [self unschedule:_cmd];
  [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
}

-(void) nextLevel: (ccTime) dt
{
  [self unschedule:_cmd];
  //check for iap
  //TODO ==============
  //TODO ==============
  //TODO ==============
  //TODO ==============
  //if ([Level current] == [Level top]) {
  if ([Level current] != [Level top]) {
    UIAlertView *alertView = [[UIAlertView alloc] init];
    [alertView setTitle:@"Level completed!"];
    [alertView setMessage:@"Do you want to get more levels?"];
    [alertView setDelegate:self];
    [alertView addButtonWithTitle:@"Yes"];
    [alertView addButtonWithTitle:@"No"];
    [alertView show];
    [alertView release];
  }else {
    [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
  }
}

//select iap
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject: [Level nextTopIdentifier]]]; 
    request.delegate = self; 
    [request start]; 
  }else if (buttonIndex == 1) {
    [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
  }
}

#pragma mark request delegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{  
  SKPayment *payment = [SKPayment paymentWithProductIdentifier:[Level nextTopIdentifier]]; 
  [[SKPaymentQueue defaultQueue] addPayment:payment]; 
  [request autorelease];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{  
  UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert" message:[error localizedDescription]  delegate:nil 
                                            cancelButtonTitle:NSLocalizedString(@"Close",nil)  otherButtonTitles:nil];  [alerView show]; [alerView release]; 
}

- (void)click: (Ball *) ball
{
  [ball show];
  if (! [ball clickCorrect]) {
    //play sound
    [[SimpleAudioEngine sharedEngine] playEffect:@"fail.mp3"];
    for (Ball *otherBall in self.balls) {
      [otherBall show];
      
      CCSprite *fail = [CCSprite spriteWithFile:@"fail.png"];
      CGSize size = [[CCDirector sharedDirector] winSize];
      fail.position = ccp(size.width/2, size.height/2);
      [self addChild:fail];
      
      [self schedule:@selector(restart:) interval:3.0f];
    }
  }else {
    if ([ball number] == ([Level current] - 1)){
      //play sound
      [[SimpleAudioEngine sharedEngine] playEffect:@"success.mp3"];
      CCSprite *pass = [CCSprite spriteWithFile:@"pass.png"];
      CGSize size = [[CCDirector sharedDirector] winSize];
      pass.position = ccp(size.width/2, size.height/2);
      [self addChild:pass];
      
      [Level increment];
      [self schedule:@selector(nextLevel:) interval:1.0f];
    } else {
      //play sound
      [[SimpleAudioEngine sharedEngine] playEffect:@"click.mp3"];
    }

  }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
  [balls release];
  [positions release];
  
	[super dealloc];
}
@end
