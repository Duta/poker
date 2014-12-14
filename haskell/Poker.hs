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

type HoleCards = (Card, Card)

data CommunityCards
  = Preflop
  | Flop  Card Card Card
  | Turn  Card Card Card Card
  | River Card Card Card Card Card
    deriving Show

type ChipCount = Integer

data Player = Player
  { _holeCards :: Maybe HoleCards
  , _chips :: ChipCount
  } deriving Show

data Game = Game
  { _players :: [Player]
  , _commCards :: CommunityCards
  } deriving Show

type Deck = [Card]

data Action
  = Fold
  | Call ChipCount -- ChipCount actually required?
  | Raise ChipCount
    deriving Show

data HandType
  = HighCard      Rank
  | OnePair       Rank
  | TwoPair       Rank Rank -- First rank is the higher
  | ThreeOfAKind  Rank
  | Straight      Rank      -- Highest rank of the straight
  | Flush         Rank      -- Highest rank of the flush
  | FullHouse     Rank Rank -- First rank is the triple
  | Quads         Rank Rank -- First rank is that of the quads, second is the kicker
  | StraightFlush Rank      -- Highest rank of the straight flush
  | RoyalFlush
    deriving (Show, Eq, Ord)

getType :: CommunityCards -> HoleCards -> HandType
getType commCards holeCards = getType' cards
 where
  mergeIntoList :: CommunityCards -> HoleCards -> [Card]
  mergeIntoList  Preflop                    (hc1, hc2) = [                         hc1, hc2]
  mergeIntoList (Flop  cc1 cc2 cc3)         (hc1, hc2) = [cc1, cc2, cc3,           hc1, hc2]
  mergeIntoList (Turn  cc1 cc2 cc3 cc4)     (hc1, hc2) = [cc1, cc2, cc3, cc4,      hc1, hc2]
  mergeIntoList (River cc1 cc2 cc3 cc4 cc5) (hc1, hc2) = [cc1, cc2, cc3, cc4, cc5, hc1, hc2]

  cards :: [Card]
  cards = mergeIntoList commCards holeCards

  getType' :: [Card] -> HandType
  getType' cs = _ht
