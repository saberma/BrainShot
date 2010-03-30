//
//  Position.m
//  BrainShot
//
//  Created by  cogent on 10-3-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Position.h"


@implementation Position

@synthesize left, right;

+ (Position *)atLeft:(int)left andRight:(int)right
{
  Position *position = [[[Position alloc] init] autorelease];
  [position setLeft:left];
  [position setRight:right];
  return position;
}

@end
