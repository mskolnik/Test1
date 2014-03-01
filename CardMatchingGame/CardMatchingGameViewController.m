//
//  CardMatchingGameViewController.m
//  CardMatchingGame
//
//  Created by MariAnne Skolnik on 2/27/14.
//  Copyright (c) 2014 MariAnne Skolnik. All rights reserved.
//


#import "CardMatchingGameViewController.h"
#import "PlayingCardDeck.h"

@implementation CardMatchingGameViewController :

- (Deck *)createDeck // abstract method
{
    return [[PlayingCardDeck alloc] init];
}

@end