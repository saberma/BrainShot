//
//  MyStoreObserver.h
//  BrainShot
//
//  Created by  saberma on 10-4-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import <StoreKit/StoreKit.h> 
#import "cocos2d.h"
#import "Level.h"
#import "LevelScene.h"

@interface MyStoreObserver : NSObject< SKPaymentTransactionObserver > {

}

- (void)paymentQueue: (SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions; 

- (void)completeTransaction: (SKPaymentTransaction *)transaction; 

- (void)failedTransaction: (SKPaymentTransaction *)transaction;

- (void) restoreTransaction: (SKPaymentTransaction *)transaction;

- (void) provideContent: (NSString *)productIdentifier;

@end
