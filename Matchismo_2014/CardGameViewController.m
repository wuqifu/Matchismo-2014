//
//  CardGameViewController.m
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import "CardGameViewController.h"
#import "model/Deck.h"
#import "model/PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;

@end

@implementation CardGameViewController

-(Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    
    return _deck;
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipcount change to: %d", self.flipCount);
    
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        
        Card *card = [self.deck drawRandomCard];
        if (card != nil) {
            [sender setTitle:card.contents
                    forState:UIControlStateNormal];
        } else {
            NSLog(@"All cards has been fliped");
        }
    }
    
    self.flipCount++;
}



@end
