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

@protocol BallDelegate;

@interface Ball : CCSprite <CCTargetedTouchDelegate> {
  int number;
  id <BallDelegate> delegate;
  //while ball hide, we can click it
  BOOL clickable;
}

@property (nonatomic) int number;
@property (nonatomic, readonly) CGRect rect;
@property (nonatomic, retain) id <BallDelegate> delegate;
@property BOOL clickable;

+ (Ball *)withLabel:(int)number AtLeftIndex:(int)leftIndex AndRightIndex:(int)rightIndex;
+ (void)clearClicked;

- (void)hide;
- (void)show;

- (BOOL)clickCorrect;

@end

@protocol BallDelegate <NSObject>
- (void)click:(Ball *) ball;
@end
