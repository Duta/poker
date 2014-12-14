module Poker where

data Rank
  = Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  | Ten
  | Jack
  | Queen
  | King
  | Ace
    deriving (Show, Eq, Ord)

data Suit
  = Spades
  | Clubs
  | Hearts
  | Diamonds
    deriving (Show, Eq, Ord)

data Card = Card
  { _rank :: Rank
  , _suit :: Suit
  } deriving (Show, Eq, Ord)

type Hand = (Card, Card)

data CommunityCards
  = Preflop
  | Flop  Card Card Card
  | Turn  Card Card Card Card
  | River Card Card Card Card Card
    deriving Show

type ChipCount = Integer

data Player = Player
  { _holeCards :: Maybe Hand
  , _chips :: ChipCount
  } deriving Show

data Game = Game
  { _players :: [Player]
  , _communityCards :: CommunityCards
  } deriving Show

type Deck = [Card]
