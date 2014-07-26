//
//  CardMatchingGame.h
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-21.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)restart;


@property (nonatomic, strong) NSString *hintString;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, getter = isTwoCardMatchMode) BOOL twoCardMatchMode;

@end
