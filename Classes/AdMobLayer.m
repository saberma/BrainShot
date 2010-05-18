//
//  AdMob.m
//  EyeRelax
//
//  Created by saberma on 10-5-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdMobLayer.h"


@implementation AdMobLayer

- (void)didReceiveAd:(AdMobView *)adView {
  
	// put the ad at the top middle of the screen in landscape mode
	//adMobAd.frame = CGRectMake(0, 432, 320, 48);
	adMobAd.frame = CGRectMake(0, 432, 320, 48);
	CGAffineTransform makeLandscape = CGAffineTransformMakeRotation(M_PI * 0.5f);
	makeLandscape = CGAffineTransformTranslate(makeLandscape, -216, -134);//centers the ad in landscape mode
	adMobAd.transform = makeLandscape;
	[[[CCDirector sharedDirector] openGLView] addSubview:adMobAd];
	[refreshTimer invalidate];
	refreshTimer = [NSTimer scheduledTimerWithTimeInterval:AD_REFRESH_PERIOD target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];
}

- (void)onEnter {
	adMobAd = [AdMobView requestAdWithDelegate:self];
	[adMobAd retain];
	[super onEnter];
}

- (void)onExit {
	[adMobAd removeFromSuperview];
	[adMobAd release];
	[super onExit];
}

// Request a new ad. If a new ad is successfully loaded, it will be animated into location.
- (void)refreshAd:(NSTimer *)timer {
	[adMobAd requestFreshAd];
}

// AdMobDelegate methods

- (NSString *)publisherId {
	return @"a14be1829817892"; // this is your publisher ID
}

- (UIColor *)adBackgroundColor {
	return [UIColor colorWithRed:0.4 green:0.6 blue:0.2 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)primaryTextColor {
	return [UIColor whiteColor]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)secondaryTextColor {
	return [UIColor colorWithRed:0.4 green:0.6 blue:0.2 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (BOOL)mayAskForLocation {
	return NO; // this should be prefilled; if not, see AdMobProtocolDelegate.h for instructions
}

- (UIViewController *)currentViewController {
  return nil;
}
@end
