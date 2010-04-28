//
//  MyStoreObserver.m
//  BrainShot
//
//  Created by  saberma on 10-4-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyStoreObserver.h"


@implementation MyStoreObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions { 
  for (SKPaymentTransaction* transaction in transactions)  {  
    switch (transaction.transactionState)  {  
      case SKPaymentTransactionStatePurchased:  
        [self completeTransaction:transaction];  
        break;  
      case SKPaymentTransactionStateFailed: 
        [self failedTransaction:transaction];  
        break;  
      case SKPaymentTransactionStateRestored: 
        break;  
      default:  
        break;  
    }  
  } 
} 

- (void)completeTransaction: (SKPaymentTransaction *)transaction{
  [self provideContent: transaction.payment.productIdentifier];
  // Remove the transaction from the payment queue.
  [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)failedTransaction: (SKPaymentTransaction *)transaction{
  if (transaction.error.code != SKErrorPaymentCancelled)
  {
    // Optionally, display an error here.
  }
  [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
  [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction{
  [self provideContent: transaction.originalTransaction.payment.productIdentifier];
  [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) provideContent: (NSString *)productIdentifier{
  Level *level = [Level get];
  [level setIap:[NSNumber numberWithInt:(level.iap.intValue+1)]];
  [level save];
  [[CCDirector sharedDirector] replaceScene: [LevelScene node]];
}

@end
