//
//  CardGameViewController.h
//  CardMatchingGame
//
//  Created by MariAnne Skolnik on 2/27/14.
//  Copyright (c) 2014 MariAnne Skolnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController <UIAlertViewDelegate>

// protected
// for subclasses
- (Deck *)createDeck; // abstract method

@end
