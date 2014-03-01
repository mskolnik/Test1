//
//  CardMatchingGame.m
//  CardMatchingGame
//
//  Created by MariAnne Skolnik on 2/27/14.
//  Copyright (c) 2014 MariAnne Skolnik. All rights reserved.
//
#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;    // make score writable in out private API
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *history;
@end

@implementation CardMatchingGame

- (NSMutableArray *)history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

- (NSArray *)matchHistory {
    return self.history;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


static const int MATCH_SUIT_BONUS = 4;
static const int MATCH_RANK_BONUS = 16;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            NSString *feedback = [[NSString alloc] initWithFormat:@"Un-picked %@", card.contents];
            [self.history addObject:@[feedback]];
        } else {
            // match against other card(s)
            NSMutableArray *matchedCards = [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    // add matched card to array
                    [matchedCards addObject:otherCard];
                }
            }
            
            // check if the number of cards for this gametype have been flipped
            if ([matchedCards count] == (self.gameType + 1)) {
                // calculate match score
                int matchScore = [card match:matchedCards];
                
                if (matchScore) {
                    // increase score
                    self.score += (matchScore * MATCH_RANK_BONUS);
                    
                    // mark cards as matched
                    card.matched = YES;
                    for (Card *otherCard in matchedCards) {
                        otherCard.matched = YES;
                    }
                    
                    [self.history addObject:[card matchHistory]];
                }
                else if (card.contents.equals(othercard.contents)){
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            // add matched card to array
                            [matchedCards addObject:otherCard];
                        }
                        
                    self.score += (matchScore * MATCH_SUIT_BONUS);
                }
            } else {
                NSString *feedback = [[NSString alloc] initWithFormat:@"Picked %@", card.contents];
                [self.history addObject:@[feedback]];
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
