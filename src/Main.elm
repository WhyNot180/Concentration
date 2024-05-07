module Main exposing (cartesianProduct, main)

import Browser
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Material.Button as Button
import Material.ImageList as ImageList
import Material.ImageList.Item as ImageListItem
import Material.LayoutGrid as LayoutGrid
import Material.Typography as Typography
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


type alias Model =
    { cards : List ( CardRank, CardSuit ) }


initialModel : () -> ( Model, Cmd Msg )
initialModel _ =
    ( { cards =
            cartesianProduct
                [ Joker, Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two ]
                [ Hearts, Spades, Diamonds, Clubs ]
      }
    , Cmd.none
    )


type Msg
    = ListCards (List ( CardRank, CardSuit ))
    | GameStart


view : Model -> Html Msg
view model =
    LayoutGrid.layoutGrid [ Typography.typography ]
        [ LayoutGrid.inner []
            [ LayoutGrid.cell [ LayoutGrid.span1Phone, LayoutGrid.alignBottom ] [ Html.h3 [ Typography.headline3 ] [ Html.text "Turns: " ] ]
            , LayoutGrid.cell [ LayoutGrid.span2Phone, LayoutGrid.alignBottom ] [ Html.h2 [ Typography.headline2 ] [ Html.text "00:00:00" ] ]
            , LayoutGrid.cell [ LayoutGrid.span1Phone, LayoutGrid.alignBottom ] [ Button.raised (Button.config |> Button.setOnClick GameStart) "Start" ]
            , LayoutGrid.cell [ LayoutGrid.span12Desktop, LayoutGrid.span4Phone ]
                [ ImageList.imageList (ImageList.config |> ImageList.setAttributes [ style "columns" "14"] |> ImageList.setMasonry True)
                    (List.map
                        (\( x, y ) ->
                            ImageListItem.imageListItem
                                (ImageListItem.config
                                    |> ImageListItem.setAttributes [ style "width" "90%", style "margin" "2px", style "height" "auto" ]
                                )
                            <|
                                "../Images/Cards/"
                                    ++ cardRankToImageName x
                                    ++ cardSuitToImageName y
                                    ++ ".png"
                        )
                        model.cards
                    )
                ]
            ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GameStart ->
            ( model
            , cartesianProduct
                [ Joker, Ace, King, Queen, Jack, Ten, Nine, Eight, Seven, Six, Five, Four, Three, Two ]
                [ Hearts, Spades, Diamonds, Clubs ]
                |> shuffle
                |> generate ListCards
            )

        ListCards cardList ->
            ( Model cardList, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


cartesianProduct : List a -> List b -> List ( a, b )
cartesianProduct xs ys =
    List.concatMap
        (\x -> List.map (\y -> ( x, y )) ys)
        xs


main =
    Browser.element { init = initialModel, subscriptions = subscriptions, update = update, view = view }
