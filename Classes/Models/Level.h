//
//  Level.h
//  BrainShot
//
//  Created by  cogent on 10-3-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"


@interface Level : SQLitePersistentObject {
  NSNumber *current;
  NSNumber *max;
  NSNumber *iap;
}
@property (nonatomic, retain) NSNumber *current, *max, *iap;

+ (int)balls;
//show time
+ (int)interval;
//top level
+ (int)top;
+ (int)max;
+ (int)current;
+ (Level *)get;
+ (void)increment;
+ (void)reset;
+ (void)gotoMax;

//iap level product identifier
//+ (NSString *)nextTopIdentifier;

@end
