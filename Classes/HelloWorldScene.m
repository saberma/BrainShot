//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "Ball.h"

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
		
    int sum = 0;
    
    NSMutableArray *tmpBalls = [[NSMutableArray alloc] init];
    
    for (int left=0; left<10; left++) {
      for (int right=0; right<6; right++) {
        sum++;
        Ball *ball = [Ball withLabel:sum AtLeftIndex:left AndRightIndex:right];
        [tmpBalls addObject:ball];
        [self addChild:ball];
      }
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
