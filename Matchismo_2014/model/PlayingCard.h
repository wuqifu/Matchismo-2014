//
//  PlayingCard.h
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
