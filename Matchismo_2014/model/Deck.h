//
//  Deck.h
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
