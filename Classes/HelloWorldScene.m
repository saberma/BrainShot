//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
// HelloWorld implementation
@implementation HelloWorld

@synthesize balls;

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
    NSMutableArray *tmpBalls = [[NSMutableArray alloc] init];
    NSMutableArray *positions = [[NSMutableArray alloc] init];
    
    int count = 5;
    
    for (int left=0; left<10; left++) {
      for (int right=0; right<6; right++) {
        Position *position = [Position atLeft:left andRight:right];
        [positions addObject:position];
      }
    }
    
    for (int number=0; number<count; number++) {
      int rand = arc4random() % [positions count];
      Position *position = [positions objectAtIndex:rand];
      [positions removeObjectAtIndex:rand];
      Ball *ball = [Ball withLabel:number AtLeftIndex:position.left AndRightIndex:position.right];
      [ball setDelegate:self];
      [tmpBalls addObject:ball];
      [self addChild:ball];
    }
    [self setBalls:tmpBalls];
    [tmpBalls release];
    
    [self schedule:@selector(hide:) interval:1.0f];
	}
	return self;
}

-(void) hide: (ccTime) dt
{
  [self unschedule:_cmd];
  for (Ball *ball in self.balls) {
    [ball hide];
  }
}

- (void)click: (Ball *) ball
{
  [ball show];
  if (! [ball clickCorrect]) {
    for (Ball *otherBall in self.balls) {
      [otherBall show];
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
	[super dealloc];
}
@end
