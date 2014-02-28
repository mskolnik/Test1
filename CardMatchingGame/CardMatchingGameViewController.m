//
//  CardMatchingGameViewController.m
//  CardMatchingGame
//
//  Created by MariAnne Skolnik on 2/27/14.
//  Copyright (c) 2014 MariAnne Skolnik. All rights reserved.
//

#import "CardMatchingGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGameViewController ()

@end

@implementation CardMatchingGameViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    PlayingCardDeck *playingDeck = [[PlayingCardDeck alloc] init];
    
	self.game = [[CardMatchingGame alloc] initWithCardCount:16 usingDeck:playingDeck];
    [self collectButtons];
    self.flipBoolArray = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", @"0", @"0",
                          @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", @"0", nil];
    
    NSLog(@"%@", @"Created");
    NSLog(@"%lu", (unsigned long)[self.game.cards count]);
    
    for (int i = 0; i < [self.game.cards count]; i++)
    {
        NSLog(@"%@", [self.game.cards objectAtIndex:i]);
    }
}

- (void)collectButtons
{
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.button0, self.button1, self.button2,
                        self.button3, self.button4, self.button5, self.button6, self.button7,
                        self.button8, self.button9, self.button10, self.button11, self.button12,
                        self.button13, self.button14, self.button15, nil];
    self.cardCollection = [[NSMutableArray alloc] init];
    [self.cardCollection addObjectsFromArray:buttons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)applicationDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (IBAction)flipCard:(id)sender {
    NSUInteger index = [self.cardCollection indexOfObject:sender];
    NSLog(@"%@", self.flipBoolArray[index]);
    // If it's already flipped
    //if ([self.flipBoolArray[index] isEqual:@"1"])
    if ([self.flipBoolArray[index] isEqualToString:@"1"])
    {
        [sender setTitle:@" " forState:UIControlStateNormal];
        /*
         UIImage *muhlImg = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/muhback.png",[self applicationDirectory]]];
         [sender setBackgroundImage:muhlImg];
         */
        self.flipBoolArray[index] = @"0";
    }
    // If it's not flipped
    else
    {
        NSString *cardContents = [[NSString alloc] init];
        Card *card = [self.game cardAtIndex:index];
        cardContents = card.contents;
        [sender setTitle:cardContents forState:UIControlStateNormal];
        /*
         UIImage *blankImg = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/blank.png",[self applicationDirectory]]];
         [sender setBackgroundImage:blankImg];
         */
        self.flipBoolArray[index] = @"1";
    }
    
}
@end
