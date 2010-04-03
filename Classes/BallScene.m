//
// cocos2d Hello World example
// http://www.cocos2d-iphone.org
//

#import "BallScene.h"


@implementation BallScene

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
    [self addChild:[BallLayer node]];
    [self addChild:[ScoreLayer node]];
	}
	return self;
}

@end
