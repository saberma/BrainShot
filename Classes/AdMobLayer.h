//
//  AdMob.h
//  EyeRelax
//
//  Created by saberma on 10-5-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AdMobView.h"
#import "AdMobDelegateProtocol.h"
#define AD_REFRESH_PERIOD 60.0 // display fresh ads once per minute


@interface AdMobLayer : CCLayer <AdMobDelegate> {
  AdMobView *adMobAd;  
  NSTimer *refreshTimer; // timer to get fresh ads
}

@end
