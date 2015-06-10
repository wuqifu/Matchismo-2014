//
//  PlayingCardDeck.m
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck



- (void)addCardsToDeck
{
    for (NSString *suit in [PlayingCard validSuits]) {
        for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            card.rank = rank;
            card.suit = suit;
            [self addCard:card];
        }
    }
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self addCardsToDeck];
    }
    
    return self;
}

- (void)resetDeck
{
    [super resetDeck];
    
    [self addCardsToDeck];
}

@end
