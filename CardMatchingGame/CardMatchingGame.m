//
//  CardMatchingGame.m
//  CardMatchingGame
//
//  Created by MariAnne Skolnik on 2/27/14.
//  Copyright (c) 2014 MariAnne Skolnik. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

//@property (readwrite, nonatomic) NSInteger score;
//@property (strong, nonatomic) NSMutableArray *cards;
//@property (strong, nonatomic) Deck *deck;

@end

@implementation CardMatchingGame
@synthesize score = _score;

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    self.cards = [[NSMutableArray alloc] init];
    
    if (self) {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card){
                self.cards[i] = card;
            }
            else {
                self = nil;
                break;
            }
        }
    }
    NSLog(@"%lu", (unsigned long)self.cards.count);
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return [self.cards objectAtIndex:index];
}

@end

