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
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    
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
                NSLog(@"All cards have been sent.");
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
    
    NSMutableString *matchInfo = [[NSMutableString alloc] init];
    if (card.isChosen) {
        card.chosen = NO;
    } else {
        card.chosen = TRUE;
        [matchInfo appendFormat:@"%@", card.contents];
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
        
        // Matched J♥ J♠ for 4 points.” or “6♦ J♣ don’t match! 2 point penalty!” or “8♦” if only one card is chosen or even blank if no cards are chosen.
        if ((chosenCards.count == 1 && self.isTwoCardMatchMode) ||
            (!self.isTwoCardMatchMode && chosenCards.count == 2)) {
            int matchScore = [card match:chosenCards];
            if (matchScore) {       // match
                int scorePoints =  matchScore * MATCH_BONUS;;
                self.score += scorePoints;
                card.matched = YES;
                
                [matchInfo setString:@""];
                [matchInfo appendFormat:@"Matched %@ ", card.contents];
                // mark the chosencards as matched
                for (Card* chosenCard in chosenCards) {
                    chosenCard.matched = YES;
                    
                    [matchInfo appendFormat:@"%@ ", chosenCard.contents];
                }
                [matchInfo appendFormat:@"for %d points.", scorePoints];
                
            } else {                // not match
                self.score -= MISMATCH_PENALTY;
                
                for (Card* chosenCard in chosenCards) {
                    [matchInfo appendFormat:@"%@ ", chosenCard.contents];
                }
                [matchInfo appendFormat:@"don't match! %d point penalty!", MISMATCH_PENALTY];
                
                // unchoose the first card.
                ((Card *)[chosenCards firstObject]).chosen = NO;    // If empty, firstObject return nil do nothing
            }
        }
    }
    
    self.hintString = matchInfo;
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
