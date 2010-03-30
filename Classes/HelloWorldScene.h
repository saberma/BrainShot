
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface HelloWorld : CCLayer
{
  NSMutableArray *balls;
}

@property (nonatomic, retain) NSMutableArray *balls;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) hide: (ccTime) dt;
@end
