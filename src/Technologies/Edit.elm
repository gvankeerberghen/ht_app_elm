module Technologies.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Msgs exposing (Msg)
import Models exposing (Technology)
import Routing exposing (technologiesPath)
import Html.Events exposing (onClick)


view : Technology -> Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Technology -> Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Technology -> Html Msg
form technology =
    div [ class "m3" ]
        [ h1 [] [ text technology.name ]
        , formVote technology
        ]


formVote : Technology -> Html Msg
formVote technology =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Votes" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString technology.votes) ]
            , btnLevelDecrease technology
            , btnLevelIncrease technology
            ]
        ]


btnLevelDecrease : Technology -> Html Msg
btnLevelDecrease technology =
    let 
        message = 
            Msgs.ChangeVotes technology -1
    in
        a [ class "btn ml1 h1", onClick message]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Technology -> Html Msg
btnLevelIncrease technology =
    let 
        message = 
            Msgs.ChangeVotes technology 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href technologiesPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]