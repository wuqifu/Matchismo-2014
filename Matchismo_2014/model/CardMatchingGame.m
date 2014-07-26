//
//  CardMatchingGame.m
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-21.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;    //of cards
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; ++i) {
            Card *card =[deck drawRandomCard];
            if (card != nil) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card.isMatched) {
        return;     // already matched, no process needed
    }
    
    if (card.isChosen) {
        card.chosen = NO;
    } else {
        card.chosen = TRUE;
        self.score -= COST_TO_CHOOSE;       // pay for single click
        
        NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
        
        // match against other chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard == card) {
                continue;   // it is itself, continue loop
            }
            
            if (otherCard.isChosen && !otherCard.isMatched) {
                [chosenCards addObject:otherCard];
                
                if ([self isTwoCardMatchMode]) {
                    break;      // found the only other chosen card
                    
                }
                
                if ([chosenCards count] == 2) {
                    break;     // found two other chosen card
                }
            }
        }
        
        if ((chosenCards.count == 1 && self.isTwoCardMatchMode) ||
            (!self.isTwoCardMatchMode && chosenCards.count == 2)) {
            int matchScore = [card match:chosenCards];
            if (matchScore) {       // match
                self.score += matchScore * MATCH_BONUS;
                card.matched = YES;
                
                // mark the chosencards as matched
                for (Card* chosenCard in chosenCards) {
                    chosenCard.matched = YES;
                }
            } else {                // not match
                self.score -= MISMATCH_PENALTY;
                
                // unchoose the first card.
                ((Card *)[chosenCards firstObject]).chosen = NO;    // If empty, firstObject return nil do nothing
            }
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    if (index < [self.cards count]) {
        return self.cards[index];
    }
    
    return nil;
}

-(void)restart {
    self.score = 0;
}

@end
