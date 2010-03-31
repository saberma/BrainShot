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
}
@property (nonatomic, retain) NSNumber *current, *max;

+ (int)max;
+ (int)current;
+ (Level *)get;
+ (void)increment;

@end
