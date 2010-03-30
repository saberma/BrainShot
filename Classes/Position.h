//
//  Position.h
//  BrainShot
//
//  Created by  cogent on 10-3-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Position : NSObject {
  int left;
  int right;
}

@property int left, right;

+ (Position *)atLeft:(int)left andRight:(int)right;
@end
