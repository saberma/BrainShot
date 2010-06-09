//
//  BallLayer.h
//  BrainShot
//
//  Created by  cogent on 10-4-3.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Ball.h"
#import "LevelScene.h"
#import "ScoreLayer.h"
#import "Position.h"
#import <StoreKit/StoreKit.h> 

//@interface BallLayer : CCLayer < BallDelegate, UIAlertViewDelegate, SKProductsRequestDelegate>
@interface BallLayer : CCLayer < BallDelegate>
{
  NSMutableArray *balls;
  NSArray *positions;
  int level;
}

@property (nonatomic, retain) NSMutableArray *balls;
@property (nonatomic, retain) NSArray *positions;
@property int level;

-(void) start;

-(void) hide: (ccTime) dt;
-(void) restart: (ccTime) dt;
-(void) nextLevel: (ccTime) dt;

@end
