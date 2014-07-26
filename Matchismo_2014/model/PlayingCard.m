//
//  PlayingCard.m
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {              // two-cards-match-model
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if([otherCards count] == 2) {        // three-cards-match-model
        PlayingCard *firstCard  = otherCards[0];
        PlayingCard *secondCard = otherCards[1];
        
        // let's make one simple algorithm
        if (firstCard.rank == self.rank || secondCard.rank == self.rank || firstCard.rank == secondCard.rank) {
            score = 2;
        } else if ([firstCard.suit isEqualToString:self.suit] || [secondCard.suit isEqualToString:self.suit] || [firstCard.suit isEqualToString:secondCard.suit]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♥", @"♦"];
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",
             @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}



@end
