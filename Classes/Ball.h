//
//  Ball.h
//  BrainShot
//
//  Created by  cogent on 10-3-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <Foundation/Foundation.h>

#define ballSize 48


@interface Ball : CCSprite <CCTargetedTouchDelegate> {
  int number;
}

@property (nonatomic) int number;
@property(nonatomic, readonly) CGRect rect;

+ (Ball *)withLabel:(int)number AtLeftIndex:(int)leftIndex AndRightIndex:(int)rightIndex;

- (void)hide;
- (void)show;

@end
