//
//  Level.m
//  BrainShot
//
//  Created by  cogent on 10-3-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Level.h"


@implementation Level
@synthesize current, max;

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
    [firstLevel save];
    level = firstLevel;
    [firstLevel release];
    [firstLevel setCurrent:[NSNumber numberWithInt:5]];
    return level;
  }
  level = [levels objectAtIndex:0];
  return level;
}

+ (void)increment
{
  Level *level = [self get];
  [level setCurrent:[NSNumber numberWithInt:self.current + 1]];
  if ([level.current intValue] > 60) {
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

- (void)dealloc
{
  [current release];
  [max release];
  [super dealloc];
}
@end
