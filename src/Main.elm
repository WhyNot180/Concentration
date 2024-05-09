module Main exposing (cartesianProduct, main)

import Browser
import Delay
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Material.Button as Button
import Material.ImageList as ImageList
import Material.ImageList.Item as ImageListItem
import Material.LayoutGrid as LayoutGrid
import Material.Typography as Typography
import Random 
import Random.List exposing (shuffle)
import Time


main =
    Browser.element { init = initialModel, subscriptions = subscriptions, update = update, view = view }

-- Everything our view needs
type alias Model =
    { cards : List ( CardRank, CardSuit )
    , selectedCard : ( CardRank, CardSuit )
    , faceUpCards : List ( CardRank, CardSuit )
    , turns : Int
    , time : Int }


initialModel : () -> ( Model, Cmd Msg )
initialModel _ =
    ( { cards =
            cartesianProduct
                [ Joker, Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two ]
                [ Hearts, Spades, Diamonds, Clubs ]
      , selectedCard = ( None, Hearts )
      , faceUpCards = []
      , turns = 0
      , time = 0
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    LayoutGrid.layoutGrid [ Typography.typography ]
        [ LayoutGrid.inner []

            -- Turn counter
            [ LayoutGrid.cell [ LayoutGrid.span1Phone, LayoutGrid.alignBottom ] 
                [ Html.h3 [ Typography.headline3 ] [ Html.text ("Turns: " ++ String.fromInt model.turns) ] ]

            -- Timer
            , LayoutGrid.cell [ LayoutGrid.span2Phone, LayoutGrid.alignBottom ] 
                [ Html.h2 [ Typography.headline2 ] [ Html.text (String.fromInt model.time) ] ]

            -- Start button
            , LayoutGrid.cell [ LayoutGrid.span1Phone, LayoutGrid.alignBottom ] 
                [ Button.raised (Button.config |> Button.setOnClick GenerateCards) "Start" ]

            -- Card images
            , LayoutGrid.cell [ LayoutGrid.span12Desktop, LayoutGrid.span4Phone ]
                [ List.map
                        (\( x, y ) ->
                            ImageListItem.imageListItem
                                (ImageListItem.config
                                    |> ImageListItem.setAttributes [ style "width" "90%", style "margin" "2px", Flip x y |> onClick ]
                                )
                            <|
                                if List.member ( x, y ) model.faceUpCards then
                                    "../Images/Cards/"
                                        ++ cardRankToImageName x
                                        ++ cardSuitToImageName y
                                        ++ ".png"

                                else
                                    "../Images/Cards/Back.png"
                        )
                        model.cards
                    |> ImageList.imageList (ImageList.config |> ImageList.setAttributes [ style "columns" "14" ] |> ImageList.setMasonry True)
                ]
            ]
        ]


type Msg
    = ListCards (List ( CardRank, CardSuit ))
    | GenerateCards
    | Flip CardRank CardSuit
    | RemovePair CardRank CardSuit
    | Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GenerateCards ->
            ( model
            , cartesianProduct
                [ Joker, Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two ]
                [ Hearts, Spades, Diamonds, Clubs ]
                |> shuffle
                |> Random.generate ListCards
            )

        -- Update model with random cards and reset
        ListCards cardList ->
            ( Model cardList ( None, Hearts ) [] 0 0, Cmd.none )

        Flip cardRank cardSuit ->

            -- Matching cards
            if cardRank == Tuple.first model.selectedCard then
                ( { model | selectedCard = ( None, Hearts ), faceUpCards = ( cardRank, cardSuit ) :: model.faceUpCards, turns = model.turns + 1 }, Cmd.none )

            -- No cards selected yet
            else if model.selectedCard == ( None, Hearts ) then
                ( { model | selectedCard = ( cardRank, cardSuit ), faceUpCards = ( cardRank, cardSuit ) :: model.faceUpCards }, Cmd.none )

            -- Incorrect pair of cards
            else
                ( { model | faceUpCards = ( cardRank, cardSuit ) :: model.faceUpCards, turns = model.turns + 1 }, RemovePair cardRank cardSuit |> Delay.after 500 )
        
        RemovePair cardRank cardSuit ->
            ( { model | selectedCard = ( None, Hearts ), faceUpCards = model.faceUpCards |> List.filter (\x -> (x /= ( cardRank, cardSuit )) && (x /= model.selectedCard)) }, Cmd.none )

        Tick _ ->
            ( { model | time = model.time + 1 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick


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
    | None


type CardSuit
    = Hearts
    | Spades
    | Diamonds
    | Clubs


cardRankToImageName : CardRank -> String
cardRankToImageName rank =
    case rank of
        Joker ->
            "Jo"

        Ace ->
            "A"

        King ->
            "K"

        Queen ->
            "Q"

        Jack ->
            "J"

        Ten ->
            "10"

        Nine ->
            "9"

        Eight ->
            "8"

        Seven ->
            "7"

        Six ->
            "6"

        Five ->
            "5"

        Four ->
            "4"

        Three ->
            "3"

        Two ->
            "2"

        _ ->
            ""


cardSuitToImageName : CardSuit -> String
cardSuitToImageName suit =
    case suit of
        Hearts ->
            "H"

        Spades ->
            "S"

        Diamonds ->
            "D"

        Clubs ->
            "C"

-- Returns list with all possible combinations of input lists
cartesianProduct : List a -> List b -> List ( a, b )
cartesianProduct xs ys =
    List.concatMap
        (\x -> List.map (\y -> ( x, y )) ys)
        xs
