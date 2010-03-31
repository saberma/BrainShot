
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Ball.h"
#import "Position.h"


// HelloWorld Layer
@interface HelloWorld : CCLayer < BallDelegate >
{
  NSMutableArray *balls;
  NSArray *positions;
  int level;
}

@property (nonatomic, retain) NSMutableArray *balls;
@property (nonatomic, retain) NSArray *positions;
@property int level;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

-(void) start;

-(void) hide: (ccTime) dt;
-(void) restart: (ccTime) dt;

@end
