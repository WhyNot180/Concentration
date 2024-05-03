module Main exposing (main,cartesianProduct)

import Html exposing (..)
import Browser
import Html.Attributes exposing (..)
import Html.Events exposing(onClick)
import Random exposing (generate)
import Random.List exposing (shuffle)

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

type alias Model =
    {cards : List (CardRank,CardSuit)}

initialModel : () -> (Model, Cmd Msg)
initialModel _ =
    ( Model [], Cmd.none)

type Msg
    = ListCards (List (CardRank,CardSuit))
    | GameStart

view : Model -> Html Msg
view model =
    div [ class "jumbotron" ]
        [ h1 [] [ text "Welcome to Dunder Mifflin!" ]
        , p []
            [ text "Dunder Mifflin Inc. (stock symbol "
            , strong [] [ text "DMI" ]
            , text <|
                """ 
                ) is a micro-cap regional paper and office 
                supply distributor with an emphasis on servicing 
                small-business clients.
                """
            ]
        , div [] [button [onClick GameStart] [text "Start"],
                    div [] [text (Debug.toString model)]
                ]
        ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    case msg of
        GameStart ->
            (model, cartesianProduct 
                [Joker, Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two] 
                [Hearts, Spades, Diamonds, Clubs] 
            |> shuffle
            |> generate ListCards)
        
        ListCards cardList ->
            (Model cardList, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

cartesianProduct : List a -> List b -> List (a,b)
cartesianProduct xs ys =
  List.concatMap
    ( \x -> List.map ( \y -> (x, y) ) ys )
    xs
    

main =
    Browser.element { init = initialModel, subscriptions = subscriptions, update = update, view = view}