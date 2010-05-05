//
//  Level.m
//  BrainShot
//
//  Created by  cogent on 10-3-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Level.h"


@implementation Level
@synthesize current, max, iap;

+ (int)top
{
  Level *level = [self get];
  if ([level iap] == nil) {
    [level setIap:[NSNumber numberWithInt:2]];
#ifdef FREE
    //FREE EDITION WILL BE 1
    [level setIap:[NSNumber numberWithInt:1]];
#endif
    [level save];
  }
  return [level.iap intValue] * 10;
}

+ (int)max
{
  Level *level = [self get];
  return [level.max intValue];
}

+ (int)current
{
  Level *level = [self get];
  return [level.current intValue];
}

+ (Level *)get
{
  NSArray *levels = [self allObjects];
  Level *level;
  if ([levels count] == 0) {
    Level *firstLevel = [[Level alloc] init];
    [firstLevel setCurrent:[NSNumber numberWithInt:1]];
    [firstLevel setMax:firstLevel.current];
#ifdef DEBUG
    [firstLevel setCurrent:[NSNumber numberWithInt:5]];
#endif
    [firstLevel save];
    level = firstLevel;
    [firstLevel release];
    return level;
  }
  level = [levels objectAtIndex:0];
#ifdef DEBUG
  [level setCurrent:[NSNumber numberWithInt:5]];
#endif
  return level;
}

+ (void)increment
{
  Level *level = [self get];
  [level setCurrent:[NSNumber numberWithInt:self.current + 1]];
  if ([level.current intValue] > [Level top]) {
    [level setCurrent:[NSNumber numberWithInt:1]];
  }
  if ([level.max intValue] < [level.current intValue]) {
    [level setMax:[level current]];
  }
  [level save];
}

+ (void)reset
{
  Level *level = [self get];
  [level setCurrent:[NSNumber numberWithInt:1]];  
  [level save];
}

+ (void)gotoMax
{
  Level *level = [self get];
  [level setCurrent:[NSNumber numberWithInt:self.max]];
  [level save];
}

+ (NSString *)nextTopIdentifier{
  NSString *productName = @"BrainShotx5";
#ifdef FREE
  productName = @"BrainShotFreex5";
#endif
  return [NSString stringWithFormat:@"cn.com.cogentsoft.%@.iphone.level%d", productName, [Level top] + 10];
}

- (void)dealloc
{
  [current release];
  [max release];
  [super dealloc];
}
@end
