module Cards exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Main exposing (cartesianProduct)

type CardRank 
    = Joker
    | Ace
    | King
    | Queen
    | Jack
    | Ten
    | Nine
    | Eight
    | Seven
    | Six
    | Five
    | Four
    | Three
    | Two

type CardSuit
    = Hearts
    | Spades
    | Diamonds
    | Clubs

suite : Test
suite =
    describe "Card Functions"
        [test "Combinations of Card rank and suit is 56"
            (\_ -> cartesianProduct [Joker, Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two] [Hearts, Spades, Diamonds, Clubs]
                |> List.length
                |> Expect.equal 56)
        ]