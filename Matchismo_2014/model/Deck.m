//
//  Deck.m
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
    
}
- (void)addCard:(Card *)card
{
    [self.cards addObject:card];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count] > 0) {
        unsigned int index = arc4random()%[self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

- (int)cardLeftInDeck
{
    return (int)[self.cards count];
}

- (void)resetDeck
{
    [self.cards removeAllObjects];
}

@end
