//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
// HelloWorld implementation
@implementation HelloWorld

@synthesize balls, positions, level;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

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
    
  [self schedule:@selector(hide:) interval:1.0f];
}

-(void) hide: (ccTime) dt
{
  [self unschedule:_cmd];
  for (Ball *ball in self.balls) {
    [ball hide];
  }
}

-(void) restart: (ccTime) dt
{
  [self unschedule:_cmd];
  LevelScene *levelScene = [[LevelScene alloc] init];
  [[CCDirector sharedDirector] replaceScene: levelScene];
  [levelScene release];
}

- (void)click: (Ball *) ball
{
  [ball show];
  if (! [ball clickCorrect]) {
    for (Ball *otherBall in self.balls) {
      [otherBall show];
      [self schedule:@selector(restart:) interval:1.0f];
    }
  }else if ([ball number] == ([Level current] - 1)){
    [Level increment];
    LevelScene *levelScene = [[LevelScene alloc] init];
    [[CCDirector sharedDirector] replaceScene: levelScene];
    [levelScene release];
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
