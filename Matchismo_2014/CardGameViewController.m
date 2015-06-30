//
//  CardGameViewController.m
//  Matchismo_2014
//
//  Created by Wuqifu on 14-7-19.
//  Copyright (c) 2014年 Wuqifu. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;       // Model
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.matchModeSegmentedControl.selectedSegmentIndex = 0;
    [self.game setTwoCardMatchMode:YES];
    [self.matchModeSegmentedControl addTarget:self
                                       action:@selector(selectedSegmentDidChange:)
                             forControlEvents:UIControlEventValueChanged];
}

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                   usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.matchModeSegmentedControl.enabled = NO;        // disable matchModeSegmentedControl
    
    // Modle logic here
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    // Update UI: Conroller interpret the Model into the view
    [self updateUI];
}

- (IBAction)gameReset {
    self.game = nil;
    [self.game restart];
    self.matchModeSegmentedControl.enabled = YES;
    
    [self updateUI];
}

- (void)selectedSegmentDidChange:(UISegmentedControl *)segmentedControl {
    NSInteger index = [segmentedControl selectedSegmentIndex];
    
    if (index == 0) {
        // two-card-match-mode
        NSLog(@"two-card-match-mode");
        [self.game setTwoCardMatchMode:YES];
    } else {
        // three-card-match-mode
        NSLog(@"three-card-match-mode");
        [self.game setTwoCardMatchMode:NO];
    }
}

-(void)updateUI
{
    // cycle through all the card buttons base on the corresponding card in Model
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        // set title and background for single card button
        NSString *cardTitle = [CardGameViewController titleForCard:card];
        [cardButton setTitle:cardTitle forState:UIControlStateNormal];
        
        UIImage *cardImage = [CardGameViewController backgroundImageForCard:card] ;
        [cardButton setBackgroundImage:cardImage forState:UIControlStateNormal];
        
        // disable card button since already matched
        cardButton.enabled = !card.matched;
        
        // update score label
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    
    // display hint string
    self.hintLabel.text = self.game.hintString;
}

// private helper methods
+(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

+(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
